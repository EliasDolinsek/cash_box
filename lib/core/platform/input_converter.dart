import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/cupertino.dart';

class InputConverter {

  static String validateEmail(BuildContext context, String email){
    final regex = RegExp("^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$");
    if(regex.hasMatch(email)) return null;
    return AppLocalizations.translateOf(context, "converter_failure_invalid_email");
  }

  static String validatePassword(BuildContext context, String password){
    if(password == null || password.length < 6){
      return AppLocalizations.translateOf(context, "converter_failure_password_too_short");
    } else if(password.length > 500){
      return AppLocalizations.translateOf(context, "converter_failure_password_too_short");
    } else {
      return null;
    }
  }
}