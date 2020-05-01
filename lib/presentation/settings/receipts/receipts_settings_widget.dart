import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/settings_widget.dart';
import 'package:flutter/material.dart';

class ReceiptsSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsWidget(
      title: AppLocalizations.translateOf(
          context, "receipts_settings_widget_tags"),
      content: _buildReceiptTemplatesListTile(context),
    );
  }

  Widget _buildReceiptTemplatesListTile(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.bookmark),
      ),
      title: Text(
          localizations.translate("receipt_settings_widget_edit_templates")),
      subtitle: Text(localizations
          .translate("receipt_settings_widget_edit_templates_hint")),
      trailing: MaterialButton(
        child: Text(AppLocalizations.translateOf(context, "btn_more")),
        onPressed: () {
          Navigator.of(context).pushNamed("/receiptTemplatesSettings");
        },
      ),
    );
  }
}
