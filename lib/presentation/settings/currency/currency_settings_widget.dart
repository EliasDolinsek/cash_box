import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/settings_list_tile.dart';
import 'package:flutter/material.dart';

import '../settings_widget.dart';

class CurrencySettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsWidget(
      title: AppLocalizations.translateOf(context, "txt_currency_settings"),
      content: SettingsListTile(
        title: AppLocalizations.translateOf(context, "txt_select_currency"),
        subtitle: null,
        icon: Icons.attach_money,
        onTap: () {
          Navigator.of(context).pushNamed("/currencySettings");
        },
      ),
    );
  }
}
