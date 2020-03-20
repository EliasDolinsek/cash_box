import 'package:cash_box/presentation/settings/categories/category_settings_widget.dart';
import 'package:flutter/material.dart';

import 'account_settings_widget.dart';

class SettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Container(
        constraints: BoxConstraints(maxWidth: 600),
        child: Column(
          children: <Widget>[
            AccountSettingsWidget(),
            SizedBox(height: 8.0),
            CategorySettingsWidget()
          ],
        ),
      ),
    );
  }
}
