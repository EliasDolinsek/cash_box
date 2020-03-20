import 'package:flutter/material.dart';

import 'account_settings_widget.dart';

class SettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Expanded(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            child: AccountSettingsWidget(),
          ),
        ),
      ),
    );
  }
}
