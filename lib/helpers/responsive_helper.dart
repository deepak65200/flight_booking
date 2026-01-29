import 'package:flutter/material.dart';

class ResponsiveHelper {
  static double width = 0.0;
  static double height = 0.0;
  static bool isTablet = false;

  // Update device dimensions and detect tablet mode
  static void updateSize(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    isTablet = width >= 600;
  }

  // Get device height based on fraction
  static double getHeight(BuildContext context, {double fraction = 1}) {
    return MediaQuery.of(context).size.height * fraction;
  }

  // Get device width based on fraction
  static double getWidth(BuildContext context, {double fraction = 1}) {
    return MediaQuery.of(context).size.width * fraction;
  }

  // Check if the device is a tablet
  static bool isDeviceTablet() {
    return isTablet;
  }
}
