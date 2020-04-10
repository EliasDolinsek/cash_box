import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {

  final String text;

  const ErrorTextWidget({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
