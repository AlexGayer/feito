// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginController on _LoginControllerBase, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_LoginControllerBase.loading'))
      .value;
  Computed<bool>? _$firstLoginComputed;

  @override
  bool get firstLogin =>
      (_$firstLoginComputed ??= Computed<bool>(() => super.firstLogin,
              name: '_LoginControllerBase.firstLogin'))
          .value;

  late final _$_firstLoginAtom =
      Atom(name: '_LoginControllerBase._firstLogin', context: context);

  @override
  bool get _firstLogin {
    _$_firstLoginAtom.reportRead();
    return super._firstLogin;
  }

  @override
  set _firstLogin(bool value) {
    _$_firstLoginAtom.reportWrite(value, super._firstLogin, () {
      super._firstLogin = value;
    });
  }

  late final _$_loadingAtom =
      Atom(name: '_LoginControllerBase._loading', context: context);

  @override
  bool get _loading {
    _$_loadingAtom.reportRead();
    return super._loading;
  }

  @override
  set _loading(bool value) {
    _$_loadingAtom.reportWrite(value, super._loading, () {
      super._loading = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_LoginControllerBase.login', context: context);

  @override
  Future<dynamic> login(BuildContext context) {
    return _$loginAsyncAction.run(() => super.login(context));
  }

  late final _$_signInAsyncAction =
      AsyncAction('_LoginControllerBase._signIn', context: context);

  @override
  Future<void> _signIn(BuildContext context) {
    return _$_signInAsyncAction.run(() => super._signIn(context));
  }

  late final _$_signUpAsyncAction =
      AsyncAction('_LoginControllerBase._signUp', context: context);

  @override
  Future<void> _signUp(BuildContext context) {
    return _$_signUpAsyncAction.run(() => super._signUp(context));
  }

  late final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase', context: context);

  @override
  void setFirstLogin(bool firstLog) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.setFirstLogin');
    try {
      return super.setFirstLogin(firstLog);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
firstLogin: ${firstLogin}
    ''';
  }
}
