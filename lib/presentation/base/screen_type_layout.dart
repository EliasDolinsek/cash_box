import 'package:cash_box/presentation/base/base_layout.dart';
import 'package:cash_box/presentation/base/sizing_information.dart';
import 'package:flutter/material.dart';

class ScreenTypeLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ScreenTypeLayout(
      {Key key, @required this.mobile, this.tablet, this.desktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(builder: (context, sizingInformation) {
      if (sizingInformation.deviceType == DeviceScreenType.tablet) {
        if (tablet != null) {
          return tablet;
        }
      }

      if (sizingInformation.deviceType == DeviceScreenType.desktop) {
        if (desktop != null) {
          return desktop;
        }
      }

      return mobile;
    });
  }
}
