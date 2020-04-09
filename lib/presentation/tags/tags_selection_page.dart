import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class TagsSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.translateOf(context, "txt_tags_selection"),
        ),
        backgroundColor: Colors.white,
      ),
      body: Text("Test"),
    );
  }
}
