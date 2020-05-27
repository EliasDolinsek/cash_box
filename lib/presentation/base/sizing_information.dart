import 'package:flutter/widgets.dart';

class SizingInformation {
  final Orientation orientation;
  final DeviceScreenType deviceType;
  final Size screenSize;
  final Size localWidgetSize;

  SizingInformation({
    @required this.orientation,
    @required this.deviceType,
    @required this.screenSize,
    @required this.localWidgetSize,
  });

  @override
  String toString() {
    return 'SizingInformation{orientation: $orientation, deviceType: $deviceType, screenSize: $screenSize, localWidgetSize: $localWidgetSize}';
  }
}

enum DeviceScreenType { mobile, desktop, tablet }
