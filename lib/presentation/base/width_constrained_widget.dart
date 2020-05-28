import 'package:flutter/material.dart';

class WidthConstrainedWidget extends StatelessWidget {
  final Widget child;

  const WidthConstrainedWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 800),
        child: child,
      ),
    );
  }
}
