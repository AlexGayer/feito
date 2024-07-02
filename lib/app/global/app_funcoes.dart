import 'package:feito/app/global/shared_preferences_handler.dart';

class AppFuncoes {
  Future<bool> isConfigured() async {
    final handler = SharedPreferencesHandler();
    final String edtMail = await handler.redPreferences("mail");
    final String edtPwd = await handler.redPreferences("password");

    if (edtMail.isNotEmpty && edtPwd.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
