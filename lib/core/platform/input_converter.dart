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

  static String validatePasswordConfirmation(BuildContext context, String password, String passwordConformation) {
    if(password != passwordConformation){
      return AppLocalizations.translateOf(context, "converter_failure_passwords_not_matching");
    }

    return null;
  }

  static String validateName(BuildContext context, String name) {
    if(name == null || name.isEmpty){
      return AppLocalizations.translateOf(context, "converter_failure_enter_name");
    } else {
      return null;
    }
  }
}