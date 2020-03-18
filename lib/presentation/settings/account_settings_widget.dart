import 'package:flutter/material.dart';

class AccountSettingsWidget extends StatefulWidget {
  @override
  _AccountSettingsWidgetState createState() => _AccountSettingsWidgetState();
}

class _AccountSettingsWidgetState extends State<AccountSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text("Account"),
            _buildNameField(),
            SizedBox(height: 16.0),
            _buildEmailField(),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "TODO"
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "TODO"
      ),
    );
  }
}
