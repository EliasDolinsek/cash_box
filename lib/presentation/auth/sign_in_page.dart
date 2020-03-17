import 'package:cash_box/presentation/auth/sign_in_widget.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage("res/imgs/logo.png"),
            ),
          ),
          Expanded(
            flex: 6,
            child: SignInInputWidget(),
          )
        ],
      ),
    );
  }
}