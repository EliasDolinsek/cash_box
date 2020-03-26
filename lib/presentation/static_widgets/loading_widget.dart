import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 16.0),
            Text(AppLocalizations.translateOf(context, "txt_loading"))
          ],
        ),
      ),
    );
  }
}
