import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {

  final String title;
  final Widget content;

  const SettingsWidget({Key key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 16.0),
          content
        ],
      ),
    );
  }
}
