import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/settings_list_tile.dart';
import 'package:cash_box/presentation/settings/settings_widget.dart';
import 'package:flutter/material.dart';

class ReceiptsSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return SettingsWidget(
      title: localizations.translate("receipts_settings_widget_tags"),
      content: SettingsListTile(
        title:
            localizations.translate("receipt_settings_widget_edit_templates"),
        subtitle: localizations
            .translate("receipt_settings_widget_edit_templates_hint"),
        icon: Icons.move_to_inbox,
        onTap:  () {
          Navigator.of(context).pushNamed("/receiptTemplatesSettings");
        },
      ),
    );
  }
}
