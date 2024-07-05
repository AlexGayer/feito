// ignore_for_file: use_build_context_synchronously, unused_local_variable, library_private_types_in_public_api

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
      if (e.code == 'user-not-found') {
        _loading = false;
      } else if (e.code == 'wrong-password') {
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
      await saveCampos();
      Navigator.of(context).pushNamed("/home");

      _loading = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _loading = false;
      } else if (e.code == 'email-already-in-use') {
        _loading = false;
      }
    }
  }

  @action
  void setFirstLogin(bool firstLog) {
    _firstLogin = firstLog;
  }

  saveCampos() async {
    await handler.savePreferences("mail", emailCtrl.text.trim());
    await handler.savePreferences("password", pwdCtrl.text);
  }
}
