import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class ReceiptsSettingsWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppLocalizations.translateOf(
                context, "receipts_settings_widget_tags"),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 16.0),
          _buildReceiptTemplatesListTile(context),
        ],
      ),
    );
  }

  Widget _buildReceiptTemplatesListTile(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.bookmark),
      ),
      title: Text(localizations.translate("receipt_settings_widget_edit_templates")),
      subtitle: Text(localizations.translate("receipt_settings_widget_edit_templates_hint")),
      trailing: MaterialButton(
        child: Text(AppLocalizations.translateOf(context, "btn_more")),
        onPressed: () {
          Navigator.of(context).pushNamed("/receiptTemplatesSettings");
        },
      ),
    );
  }
}
