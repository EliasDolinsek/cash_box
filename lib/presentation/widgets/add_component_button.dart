import 'package:flutter/material.dart';

class AddComponentButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const AddComponentButton({Key key, this.text = "", this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
