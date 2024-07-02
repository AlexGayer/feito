import 'package:feito/app/global/app_funcoes.dart';
import 'package:feito/app/global/app_theme.dart';
import 'package:feito/app/global/app_constants.dart';
import 'package:feito/app/global/app_routes.dart';
import 'package:feito/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

String tela = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  tela = await AppFuncoes().isConfigured() ? "/home" : "/login";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: tela,
      navigatorKey: navigatorKey,
      onGenerateRoute: Routes.generateRoute,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
    );
  }
}
