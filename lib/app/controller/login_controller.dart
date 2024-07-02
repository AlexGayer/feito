import 'package:feito/app/global/shared_preferences_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

@injectable
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();
  final newPwdCtrl = TextEditingController();
  final focusEmail = FocusNode();
  final focusPwd = FocusNode();
  final formKey = GlobalKey<FormState>();
  final handler = SharedPreferencesHandler();

  _LoginControllerBase();

  @observable
  bool _firtAccess = false;

  @observable
  bool _loading = false;

  @computed
  bool get firstAccess => _firtAccess;

  @computed
  bool get loading => _loading;

  @action
  changeFirstAcces() {
    _firtAccess = !_firtAccess;
  }

  @action
  Future login(BuildContext context) async {
    try {
      if (formKey.currentState != null) {
        if (formKey.currentState!.validate()) {
          if (_firtAccess) {
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
      print("Usuário logado: ${userCredential.user?.email}");
      await saveCampos();
      Navigator.of(context).pushNamed("/home");
      _loading = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Nenhum usuário encontrado para esse email.');
        _loading = false;
      } else if (e.code == 'wrong-password') {
        print('Senha incorreta fornecida para esse usuário.');
        _loading = false;
      }
    }
  }

  @action
  Future<void> _signUp(BuildContext context) async {
    _loading = true;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailCtrl.text, password: pwdCtrl.text);
      // Sucesso no registro
      print("Usuário registrado: ${userCredential.user?.email}");
      await saveCampos();
      Navigator.of(context).pushNamed("/home");

      _loading = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('A senha fornecida é muito fraca.');
        _loading = false;
      } else if (e.code == 'email-already-in-use') {
        print('Já existe uma conta com esse email.');
        _loading = false;
      }
    }
  }

  saveCampos() async {
    await handler.savePreferences("mail", emailCtrl.text.trim());
    await handler.savePreferences("password", pwdCtrl.text);
  }
}
