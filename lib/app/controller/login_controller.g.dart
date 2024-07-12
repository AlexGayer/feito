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

  late final _$userPhotoURLAtom =
      Atom(name: '_LoginControllerBase.userPhotoURL', context: context);

  @override
  String? get userPhotoURL {
    _$userPhotoURLAtom.reportRead();
    return super.userPhotoURL;
  }

  @override
  set userPhotoURL(String? value) {
    _$userPhotoURLAtom.reportWrite(value, super.userPhotoURL, () {
      super.userPhotoURL = value;
    });
  }

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

  late final _$nameAtom =
      Atom(name: '_LoginControllerBase.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$mailAtom =
      Atom(name: '_LoginControllerBase.mail', context: context);

  @override
  String get mail {
    _$mailAtom.reportRead();
    return super.mail;
  }

  @override
  set mail(String value) {
    _$mailAtom.reportWrite(value, super.mail, () {
      super.mail = value;
    });
  }

  late final _$pickedImageAtom =
      Atom(name: '_LoginControllerBase.pickedImage', context: context);

  @override
  XFile? get pickedImage {
    _$pickedImageAtom.reportRead();
    return super.pickedImage;
  }

  @override
  set pickedImage(XFile? value) {
    _$pickedImageAtom.reportWrite(value, super.pickedImage, () {
      super.pickedImage = value;
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

  late final _$initStateAsyncAction =
      AsyncAction('_LoginControllerBase.initState', context: context);

  @override
  Future initState() {
    return _$initStateAsyncAction.run(() => super.initState());
  }

  late final _$fetchUserPhotoURLAsyncAction =
      AsyncAction('_LoginControllerBase.fetchUserPhotoURL', context: context);

  @override
  Future<void> fetchUserPhotoURL() {
    return _$fetchUserPhotoURLAsyncAction.run(() => super.fetchUserPhotoURL());
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

  late final _$reauthenticateAsyncAction =
      AsyncAction('_LoginControllerBase.reauthenticate', context: context);

  @override
  Future<void> reauthenticate(String email, String password) {
    return _$reauthenticateAsyncAction
        .run(() => super.reauthenticate(email, password));
  }

  late final _$changePasswordAsyncAction =
      AsyncAction('_LoginControllerBase.changePassword', context: context);

  @override
  Future<void> changePassword(BuildContext context) {
    return _$changePasswordAsyncAction.run(() => super.changePassword(context));
  }

  late final _$getImageGalleryAsyncAction =
      AsyncAction('_LoginControllerBase.getImageGallery', context: context);

  @override
  Future<void> getImageGallery() {
    return _$getImageGalleryAsyncAction.run(() => super.getImageGallery());
  }

  late final _$getImageCameraAsyncAction =
      AsyncAction('_LoginControllerBase.getImageCamera', context: context);

  @override
  Future<void> getImageCamera() {
    return _$getImageCameraAsyncAction.run(() => super.getImageCamera());
  }

  late final _$uploadImageToFirebaseAsyncAction = AsyncAction(
      '_LoginControllerBase.uploadImageToFirebase',
      context: context);

  @override
  Future<void> uploadImageToFirebase() {
    return _$uploadImageToFirebaseAsyncAction
        .run(() => super.uploadImageToFirebase());
  }

  late final _$logOutAppAsyncAction =
      AsyncAction('_LoginControllerBase.logOutApp', context: context);

  @override
  Future logOutApp(BuildContext context) {
    return _$logOutAppAsyncAction.run(() => super.logOutApp(context));
  }

  late final _$getInfoUserAsyncAction =
      AsyncAction('_LoginControllerBase.getInfoUser', context: context);

  @override
  Future getInfoUser() {
    return _$getInfoUserAsyncAction.run(() => super.getInfoUser());
  }

  late final _$saveCamposAsyncAction =
      AsyncAction('_LoginControllerBase.saveCampos', context: context);

  @override
  Future<void> saveCampos([String? photoURL]) {
    return _$saveCamposAsyncAction.run(() => super.saveCampos(photoURL));
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
userPhotoURL: ${userPhotoURL},
name: ${name},
mail: ${mail},
pickedImage: ${pickedImage},
loading: ${loading},
firstLogin: ${firstLogin}
    ''';
  }
}
