import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ScreenTypeHelper extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const ScreenTypeHelper({
    super.key,
    required this.tablet,
    required this.desktop,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sized) {
        if (sized.deviceScreenType == DeviceScreenType.tablet) {
          return tablet;
        } else if (sized.deviceScreenType == DeviceScreenType.mobile) {
          return mobile;
        }
        return desktop;
      },
    );
  }
}
