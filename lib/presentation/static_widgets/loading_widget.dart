import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Loading")
          ],
        ),
      ),
    );
  }
}
