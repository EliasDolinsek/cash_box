import 'package:cash_box/presentation/base/sizing_information.dart';
import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final Widget Function(
      BuildContext context, SizingInformation sizingInformation) builder;

  const BaseLayout({Key key, @required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final SizingInformation sizingInformation = SizingInformation(
          orientation: mediaQuery.orientation,
          deviceType: getDeviceType(mediaQuery),
          screenSize: mediaQuery.size,
          localWidgetSize: Size(
            constraints.maxWidth,
            constraints.maxHeight,
          ),
        );

        return builder(context, sizingInformation);
      },
    );
  }

  DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
    var orientation = mediaQuery.orientation;

    double deviceWidth = 0;

    if (orientation == Orientation.landscape) {
      deviceWidth = mediaQuery.size.height;
    } else {
      deviceWidth = mediaQuery.size.width;
    }

    if (deviceWidth > 950) {
      return DeviceScreenType.desktop;
    }

    if (deviceWidth > 600) {
      return DeviceScreenType.tablet;
    }

    return DeviceScreenType.mobile;
  }
}
