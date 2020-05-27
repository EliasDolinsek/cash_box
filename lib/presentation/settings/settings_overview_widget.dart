import 'package:cash_box/presentation/settings/contacts/contacts_settings_widget.dart';
import 'package:cash_box/presentation/settings/receipts/receipts_settings_widget.dart';
import 'package:cash_box/presentation/settings/tags/tags_settings_widget.dart';
import 'package:cash_box/presentation/settings/buckets/buckets_settings_widget.dart';
import 'package:flutter/material.dart';

import 'accounts/account_settings_widget.dart';
import 'currency/currency_settings_widget.dart';

class SettingsOverviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: Column(
            children: <Widget>[
              AccountSettingsWidget(),
              SizedBox(height: 8.0),
              ContactsSettingsWidget(),
              SizedBox(height: 8.0),
              TagsSettingsWidget(),
              SizedBox(height: 8.0),
              ReceiptsSettingsWidget(),
              SizedBox(height: 8.0),
              BucketsSettingsWidget(),
              SizedBox(height: 8.0),
              CurrencySettingsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
