import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Image(
                image: AssetImage("res/imgs/logo.png"),
              ),
            ),
          ),
          SignInInputWidget()
        ],
      ),
    );
  }
}

class SignInInputWidget extends StatefulWidget {
  @override
  _SignInInputWidgetState createState() => _SignInInputWidgetState();
}

class _SignInInputWidgetState extends State<SignInInputWidget> {

  final SignInType signInType = SignInType.sign_in;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(AppLocalizations.translateOf(context, "test_string")),
        TextField()
      ],
    );
  }
}

enum SignInType { sign_in, register }