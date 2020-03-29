import 'package:cash_box/presentation/navigation/mobile_navigation_page.dart';
import 'package:cash_box/presentation/navigation/web_navigation_page.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth > 1000) {
          return WebNavigationPage();
        } else {
          return MobileNavigationPage();
        }
      },
    );
  }
}
