import 'package:flutter/material.dart';

class SizeControl {
  static double getHeightFromPrencentage(
      {required BuildContext context, required double percent}) {
    double sizeHeight = MediaQuery.of(context).size.height;
    return percent / 100 * sizeHeight;
  }

  static double getWidthFromPrencentage(
      {required BuildContext context, required double percent}) {
    double sizeWidth = MediaQuery.of(context).size.width;
    return percent / 100 * sizeWidth;
  }
}
