import 'package:flutter/material.dart';

import 'account_settings_widget.dart';

class SettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 500),
          child: Column(
            children: <Widget>[
              AccountSettingsWidget()
            ],
          ),
        ),
      ),
    );
  }
}


