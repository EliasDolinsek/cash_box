import 'package:flutter/material.dart';

class ComponentActionButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const ComponentActionButton({Key key, this.text = "", this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
