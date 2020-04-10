import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class LoadingTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.translateOf(context, "txt_loading"));
  }
}
