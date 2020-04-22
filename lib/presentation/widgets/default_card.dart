import 'package:flutter/material.dart';

class DefaultCard extends StatelessWidget {

  final Widget child;

  const DefaultCard({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(11.0),
      child: child,
      elevation: 4,
    );
  }
}
