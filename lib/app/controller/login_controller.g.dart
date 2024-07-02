// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginController on _LoginControllerBase, Store {
  Computed<bool>? _$firstAccessComputed;

  @override
  bool get firstAccess =>
      (_$firstAccessComputed ??= Computed<bool>(() => super.firstAccess,
              name: '_LoginControllerBase.firstAccess'))
          .value;
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_LoginControllerBase.loading'))
      .value;

  late final _$_firtAccessAtom =
      Atom(name: '_LoginControllerBase._firtAccess', context: context);

  @override
  bool get _firtAccess {
    _$_firtAccessAtom.reportRead();
    return super._firtAccess;
  }

  @override
  set _firtAccess(bool value) {
    _$_firtAccessAtom.reportWrite(value, super._firtAccess, () {
      super._firtAccess = value;
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
  dynamic changeFirstAcces() {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.changeFirstAcces');
    try {
      return super.changeFirstAcces();
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
firstAccess: ${firstAccess},
loading: ${loading}
    ''';
  }
}
