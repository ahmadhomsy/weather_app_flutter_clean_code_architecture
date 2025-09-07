import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide < 600;

  static bool isTablet(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide >= 600 && shortestSide < 900;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 900;

  @override
  Widget build(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;

    if (shortestSide >= 900) {
      return desktop;
    } else if (shortestSide >= 600) {
      return tablet;
    } else {
      return mobile;
    }
  }
}
