// ignore_for_file: use_build_context_synchronously, unused_local_variable, library_private_types_in_public_api

import 'package:feito/app/data/respository/firestore_repository.dart';
import 'package:feito/app/global/dialog_helper.dart';
import 'package:feito/app/global/shared_preferences_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

@injectable
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final FirestoreRepository _firestoreRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
  bool _firstLogin = false;

  @observable
  bool _loading = false;

  @computed
  bool get loading => _loading;

  @computed
  bool get firstLogin => _firstLogin;

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
      // Sucesso no login
      await saveCampos();
      Navigator.of(context).pushNamed("/home");
      _loading = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        DialogHelper.showConfirmationDialog(
          context,
          "Atenção",
          "Credenciais inválidas. Verifique !",
          () => Navigator.of(context).pop(),
        );
        _loading = false;
      } else if (e.code == "invalid-email") {
        DialogHelper.showConfirmationDialog(
          context,
          "Atenção",
          "O endereço de e-mail está mal formatado. Verifique!",
          () => Navigator.of(context).pop(),
        );
        _loading = false;
      }
      _loading = false;
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

      // Sucesso no registro
      await saveCampos();
      _loading = false;

      // Mostrar mensagem de sucesso

      DialogHelper.showConfirmationDialog(
        context,
        "Sucesso",
        "Cadastro realizado com sucesso !",
        () => Navigator.of(context).pushNamed("/home"),
      );
    } on FirebaseAuthException catch (e) {
      _loading = false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          String errorMessage = '';
          if (e.code == 'weak-password') {
            errorMessage = 'A senha é muito fraca.';
          } else if (e.code == 'email-already-in-use') {
            errorMessage = 'Este email já está em uso.';
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
    }
  }

  @action
  void setFirstLogin(bool firstLog) {
    _firstLogin = firstLog;
  }

  saveCampos() async {
    await handler.savePreferences("name", nameCtrl.text.trim());
    await handler.savePreferences("mail", emailCtrl.text.trim());
    await handler.savePreferences("password", pwdCtrl.text);
  }
}
