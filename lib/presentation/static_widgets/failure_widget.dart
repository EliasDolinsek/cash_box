import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class FailurePage extends StatelessWidget {
  final String errorMessageKey;

  const FailurePage(this.errorMessageKey, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translateOf(context, "failure_widget_failure")),
        backgroundColor: Colors.white,
      ),
      body: FailureWidget(errorMessageKey),
    );
  }
}

class FailureWidget extends StatelessWidget {
  final String errorMessageKey;

  const FailureWidget(this.errorMessageKey, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.translateOf(context, errorMessageKey);
    return Center(child: Text(text));
  }
}
