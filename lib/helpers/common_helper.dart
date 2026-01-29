import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/color_res.dart';

class CommonToast {
  static void show(
    BuildContext context,
    String message, {
    bool isError = false,
    Color? backgroundColor,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'MontserratLight',
            letterSpacing: 1.0,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        backgroundColor:
            isError
                ? ColorRes.redColor
                : (backgroundColor ?? const Color(0xFFBDAB20)),
        duration: duration,
      ),
    );
  }
}

class ToastUtils {
  static void _showToast(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 14.0,
    );
  }

  static void showToast(
    String message, {
    Color? backgroundColor,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    _showToast(
      message,
      gravity: gravity,
      backgroundColor: backgroundColor ?? ColorRes.primaryDark,
    );
  }

  static void showErrorToast(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    _showToast(message, gravity: gravity, backgroundColor: ColorRes.redColor);
  }
}




enum PropertyStatus{
  verified,
  rejected,
  inProgress,
  approved,
  pending,
}


enum BookingFilter {
  all,
  upcoming,
  ongoing,
  past,
  completed,
  cancelled,
}

enum ReservationStatus {
  requested,
  booked,
  upcoming,
  ongoing,
  completed,
  cancelled,
  past
}




