import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class SignInSettingsListTileDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.translateOf(
          context, "sign_in_new_account_dialog_title")),
      content: Text(AppLocalizations.translateOf(
          context, "sign_in_new_account_dialog_description")),
      actions: <Widget>[
        MaterialButton(
          child: Text(AppLocalizations.translateOf(context, "dialog_btn_cancel")),
          onPressed: () => Navigator.pop(context, false),
        ),
        MaterialButton(
          child: Text(AppLocalizations.translateOf(context, "dialog_btn_confirm")),
          onPressed: () => Navigator.pop(context, true),
        )
      ],
    );
  }
}
