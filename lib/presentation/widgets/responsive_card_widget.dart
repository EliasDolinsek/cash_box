import 'package:flutter/material.dart';

class ResponsiveCardWidget extends StatelessWidget {
  final Widget child;

  const ResponsiveCardWidget(this.child, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth > 800) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                constraints: BoxConstraints(maxWidth: 800),
                child: Card(
                  elevation: 4,
                  child: child,
                ),
              ),
            ),
          );
        } else {
          return child;
        }
      },
    );
  }
}
