import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  static double getHeightFromPrecentage(
      BuildContext context, double precentage) {
    return precentage / 100 * MediaQuery.of(context).size.height;
  }

  static double getWidthFromPrecentage(
      BuildContext context, double precentage) {
    return precentage / 100 * MediaQuery.of(context).size.width;
  }

  static double getDifferencePrecentage(
      double screenWidth, double screenHeight) {
    // print((100 *
    //         ((screenWidth - screenHeight) / ((screenWidth + screenHeight) / 2)))
    //     .toString());
    return 100 *
        ((screenWidth - screenHeight) / ((screenWidth + screenHeight) / 2));
  }

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < MediaQuery.of(context).size.height &&
      getDifferencePrecentage(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height) <
          -50 &&
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      getDifferencePrecentage(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height) <
          50 &&
      getDifferencePrecentage(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height) >
          -50 &&
      MediaQuery.of(context).size.width < 1280 &&
      MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.height < MediaQuery.of(context).size.width &&
      getDifferencePrecentage(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height) >
          50 &&
      MediaQuery.of(context).size.width >= 1280;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if (_size.width >= 1280) {
      return desktop;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (_size.width >= 850 && tablet != null) {
      return tablet!;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}
