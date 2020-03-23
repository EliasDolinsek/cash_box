import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.translateOf(context, "txt_confirm_deletion"),
      ),
      actions: <Widget>[
        _buildCancelButton(context),
        _buildDeleteButton(context)
      ],
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return MaterialButton(
      child: Text(
        AppLocalizations.translateOf(context, "btn_delete"),
      ),
      onPressed: () => Navigator.of(context).pop(true),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return MaterialButton(
      child: Text(
        AppLocalizations.translateOf(context, "dialog_btn_cancel"),
      ),
      onPressed: () => Navigator.of(context).pop(false),
    );
  }
}
