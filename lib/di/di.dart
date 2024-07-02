import 'package:feito/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await Firebase.initializeApp();
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  $initGetIt(getIt);
}
