import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

import '../settings_widget.dart';

class CurrencySettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsWidget(
      title: AppLocalizations.translateOf(context, "txt_currency_settings"),
      content: _buildCurrencySettingsListTile(context),
    );
  }

  Widget _buildCurrencySettingsListTile(BuildContext context) {
    return ListTile(
      title: Text(AppLocalizations.translateOf(context, "txt_select_currency")),
      leading: CircleAvatar(
        child: Icon(Icons.attach_money),
      ),
      trailing: MaterialButton(
        child: Text(AppLocalizations.translateOf(context, "btn_more")),
        onPressed: () {
          Navigator.of(context).pushNamed("/currencySettings");
        },
      ),
    );
  }
}
