// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:firebase_core/firebase_core.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../app/controller/login_controller.dart' as _i7;
import '../app/controller/schedule_controller.dart' as _i8;
import '../app/data/respository/firestore_repository.dart' as _i6;
import 'firebase_module.dart' as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final firebaseModule = _$FirebaseModule();
  await gh.factoryAsync<_i3.FirebaseApp>(
    () => firebaseModule.initFirebaseApp,
    preResolve: true,
  );
  gh.factory<_i4.FirebaseAuth>(() => firebaseModule.auth);
  gh.factory<_i5.FirebaseFirestore>(() => firebaseModule.firestore);
  gh.factory<_i6.FirestoreRepository>(
      () => _i6.FirestoreRepositoryImpl(get<_i5.FirebaseFirestore>()));
  gh.factory<_i7.LoginController>(() => _i7.LoginController());
  gh.factory<_i8.ScheduleController>(
      () => _i8.ScheduleController(get<_i6.FirestoreRepository>()));
  return get;
}

class _$FirebaseModule extends _i9.FirebaseModule {}
