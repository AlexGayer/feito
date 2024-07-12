// ignore_for_file: use_build_context_synchronously, unused_local_variable, library_private_types_in_public_api

import 'dart:io';
import 'package:feito/app/data/respository/firestore_repository.dart';
import 'package:feito/app/global/dialog_helper.dart';
import 'package:feito/app/global/shared_preferences_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:image_picker/image_picker.dart';
part 'login_controller.g.dart';

@injectable
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final FirestoreRepository _firestoreRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();
  final newPwdCtrl = TextEditingController();
  final focusName = FocusNode();
  final focusEmail = FocusNode();
  final focusPwd = FocusNode();
  final focusNewPwd = FocusNode();
  final formKey = GlobalKey<FormState>();
  final handler = SharedPreferencesHandler();

  _LoginControllerBase(this._firestoreRepository);

  @observable
  String? userPhotoURL;

  @observable
  bool _firstLogin = false;

  @observable
  String name = "";

  @observable
  String mail = "";

  @observable
  XFile? pickedImage;

  @observable
  bool _loading = false;

  @computed
  bool get loading => _loading;

  @computed
  bool get firstLogin => _firstLogin;

  @action
  initState() async {
    try {
      _loading = true;

      await fetchUserPhotoURL();
    } finally {
      _loading = false;
    }
  }

  @action
  Future<void> fetchUserPhotoURL() async {
    try {
      String? photoURL =
          await _firestoreRepository.getUserPhotoURL(_auth.currentUser!.uid);
      userPhotoURL = photoURL;
    } catch (e) {
      print('Erro ao buscar a URL da foto do usuário: $e');
    }
  }

  @action
  Future login(BuildContext context) async {
    try {
      if (formKey.currentState != null) {
        if (formKey.currentState!.validate()) {
          if (_firstLogin) {
            await _signUp(context);
          } else {
            await _signIn(context);
          }
        }
      }
    } catch (e) {
      return e;
    }
  }

  @action
  Future<void> _signIn(BuildContext context) async {
    _loading = true;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailCtrl.text, password: pwdCtrl.text);

      Map<String, String>? userDetails =
          await _firestoreRepository.getUserDetails(userCredential.user!.uid);
      if (userDetails != null) {
        nameCtrl.text = userDetails['displayName'] ?? '';
        emailCtrl.text = userDetails['email'] ?? '';

        String? photoURL = userDetails['photoURL'];
        if (photoURL != null && photoURL.isNotEmpty) {
          await saveCampos(photoURL); // Salva a URL da imagem
        }
      }

      saveCampos();

      Navigator.of(context).pushNamed("/home");
      _loading = false;
    } on FirebaseAuthException catch (e) {
      print(e);
      _loading = false;
      rethrow;
    }
  }

  @action
  Future<void> _signUp(BuildContext context) async {
    _loading = true;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailCtrl.text, password: pwdCtrl.text);

      // Atualizar o display name do usuário
      await userCredential.user!.updateProfile(displayName: nameCtrl.text);

      // Salvar usuário no Firestore
      await _firestoreRepository.addUser(
          userCredential.user!.uid, emailCtrl.text, nameCtrl.text);

      // Upload da imagem para o Firebase Storage
      if (pickedImage != null) {
        print('Imagem selecionada: ${pickedImage!.path}');
        await _firestoreRepository.uploadUserImage(
          _auth.currentUser!.uid,
          File(pickedImage!.path),
        );
      } else {
        print('Nenhuma imagem selecionada');
      }

      // Obtenha a URL da imagem do Firestore
      String? photoURL =
          await _firestoreRepository.getUserPhotoURL(_auth.currentUser!.uid);

      // Atualize o perfil do usuário com a URL da foto
      if (photoURL != null && photoURL.isNotEmpty) {
        await userCredential.user!.updateProfile(photoURL: photoURL);
      }

      // Sucesso no registro
      await saveCampos();
      _loading = false;

      // Mostrar mensagem de sucesso
      DialogHelper.showConfirmationDialog(
        context,
        "Sucesso",
        "Cadastro realizado com sucesso!",
        () => Navigator.of(context).pushNamed("/home"),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      DialogHelper.showConfirmationDialog(
        context,
        "Atenção",
        "O endereço de e-mail já está sendo usado por outra conta !",
        () => Navigator.of(context).pushNamed("/home"),
      );
      _loading = false;
      rethrow;
    }
  }

  @action
  Future<void> reauthenticate(String email, String password) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
      } else {
        throw FirebaseAuthException(
            code: 'user-not-logged-in', message: 'User is not logged in.');
      }
    } catch (e) {
      rethrow;
    }
  }

  @action
  Future<void> changePassword(BuildContext context) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      _loading = true;
      try {
        // Reautentica o usuário antes de alterar a senha
        await reauthenticate(emailCtrl.text, pwdCtrl.text);

        // Altera a senha do usuário
        await _firestoreRepository.changePassword(newPwdCtrl.text);
        _loading = false;

        DialogHelper.showConfirmationDialog(
          context,
          "Sucesso",
          "Senha alterada com sucesso.",
          () => Navigator.of(context).pop(),
        );
      } on FirebaseAuthException catch (e) {
        _loading = false;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            String errorMessage = '';
            if (e.code == 'weak-password') {
              errorMessage = 'A senha é muito fraca.';
            } else if (e.code == 'wrong-password') {
              errorMessage = 'A senha atual está incorreta.';
            } else if (e.code == 'user-mismatch') {
              errorMessage =
                  'As credenciais fornecidas não correspondem ao usuário logado.';
            } else {
              errorMessage = 'Ocorreu um erro. Tente novamente.';
            }
            return AlertDialog(
              title: const Text('Erro'),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (e) {
        _loading = false;
        rethrow;
      }
    }
  }

  @action
  Future<void> getImageGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage = XFile(pickedFile.path);
      print('Imagem da galeria selecionada: ${pickedImage!.path}');
    } else {
      print('Nenhuma imagem selecionada.');
    }
  }

  @action
  Future<void> getImageCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      pickedImage = XFile(pickedFile.path);
      print('Imagem da câmera selecionada: ${pickedImage!.path}');
    } else {
      print('Nenhuma imagem selecionada.');
    }
  }

  @action
  Future<void> uploadImageToFirebase() async {
    try {
      if (pickedImage != null) {
        _loading = true;

        // Upload da imagem usando o repositório
        await _firestoreRepository.uploadUserImage(
          _auth.currentUser!.uid,
          File(pickedImage!.path),
        );

        _loading = false;
      }
    } catch (e) {
      print('Erro ao enviar imagem para o Firebase Storage: $e');
      _loading = false;
    }
  }

  @action
  logOutApp(BuildContext context) async {
    await handler.removePreferences("name");
    await handler.removePreferences("mail");
    await handler.removePreferences("password");

    await Navigator.of(context).pushReplacementNamed("/inicial");
  }

  @action
  getInfoUser() async {
    name = await handler.redPreferences("name");
    mail = await handler.redPreferences("mail");
  }

  @action
  void setFirstLogin(bool firstLog) {
    _firstLogin = firstLog;
  }

  @action
  Future<void> saveCampos([String? photoURL]) async {
    await handler.savePreferences("name", nameCtrl.text.trim());
    await handler.savePreferences("mail", emailCtrl.text.trim());
    await handler.savePreferences("password", pwdCtrl.text);
    if (photoURL != null) {
      await handler.savePreferences("photoURL", photoURL);
    }
  }
}
