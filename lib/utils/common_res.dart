import 'package:flutter/material.dart';


class FontRes {
  static const String montserratLight = 'assets/font/Montserrat-Light.ttf';
  static const String montserratMedium = 'assets/font/Montserrat-Medium.ttf';
  static const String montserratSemiBold =
      'assets/font/Montserrat-SemiBold.ttf';
  static const String montserratBold = 'assets/font/Montserrat-Bold.ttf';
  static const String poppinsRegular = 'assets/fonts/poppins_regular.ttf';
}

class PaddingRes {
  static const double vi = 6;
  static const double viii = 8;
  static const double x = 10;
  static const double xii = 12;
  static const double xiv = 14;
  static const double xvi = 16;
  static const double xviii = 18;
  static const double xx = 20;
}

class TextSizeRes {
  static const double viii = 8;
  static const double x = 10;
  static const double xi = 11;
  static const double xii = 12;
  static const double xiii = 13;
  static const double xiv = 14;
  static const double xvi = 16;
  static const double xviii = 18;
  static const double xx = 20;
  static const double xxii = 22;
  static const double xxiv = 24;
  static const double xxvi = 26;
  static const double xxviii = 28;
  static const double xxxx = 40;
}

SizedBox get h2 => const SizedBox(height: 2);
SizedBox get h3 => const SizedBox(height: 3);
SizedBox get h4 => const SizedBox(height: 4);
SizedBox get h5 => const SizedBox(height: 5);
SizedBox get h6 => const SizedBox(height: 6);
SizedBox get h8 => const SizedBox(height: 8);
SizedBox get h10 => const SizedBox(height: 10);
SizedBox get h12 => const SizedBox(height: 12);
SizedBox get h15 => const SizedBox(height: 15);
SizedBox get h16 => const SizedBox(height: 16);
SizedBox get h20 => const SizedBox(height: 20);
SizedBox get h30 => const SizedBox(height: 30);
SizedBox get h40 => const SizedBox(height: 40);
SizedBox get h60 => const SizedBox(height: 60);

SizedBox get w2 => const SizedBox(width: 2);
SizedBox get w4 => const SizedBox(width: 4);
SizedBox get w5 => const SizedBox(width: 5);
SizedBox get w8 => const SizedBox(width: 8);
SizedBox get w10 => const SizedBox(width: 10);
SizedBox get w12 => const SizedBox(width: 12);
SizedBox get w15 => const SizedBox(width: 15);
SizedBox get w16 => const SizedBox(width: 16);
SizedBox get w20 => const SizedBox(width: 20);

TextStyle titleStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: Colors.black54,
);

TextStyle valueStyleBold = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

// for Api success

String code = "200";

class ValidationUtils {
  static final RegExp _emailRegex = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );
  static final RegExp _mobileRegex = RegExp(r"^[6-9]\d{8}$");

  static final RegExp _panRegex = RegExp(
    r'^[A-Z]{5}[0-9]{4}[A-Z]$',
  );


  static bool isValidEmail(String email) {
    return _emailRegex.hasMatch(email);
  }
  static bool isValidMobile(String mobile) {
    return _mobileRegex.hasMatch(mobile);
  }

  static bool isValidPan(String pan) {
    return _panRegex.hasMatch(pan);
  }
}

// String formatCurrency(num amount) {
//   final formatter = NumberFormat.decimalPattern(); // Adds commas
//   return 'XAF ${formatter.format(amount).t}';
// }
//
// String formatCurrency(num amount) {
//   final isDecimal = amount % 1 != 0;
//   final formatter = NumberFormat.currency(
//     symbol: 'XAF ',
//     decimalDigits: isDecimal ? 2 : 0,
//   );
//   return formatter.format(amount);
// }



class StringRes {
  static const String introTitle1 = 'No Upfront Investment';
  static const String introSubTitle1 =
      'Start your journey with zero initial cost — we invest in you, so you can focus on growing.';

  static const String introTitle2 = 'Lifetime Free Maintenance';
  static const String introSubTitle2 =
      'We provide free maintenance for life, ensuring your operations run smoothly without additional costs.';

  static const String introTitle3 = 'Quality Assured With IoT';
  static const String introSubTitle3 =
      'Harness the power of IoT for real-time monitoring and top-notch service quality, guaranteed.';

  //help
  static const String callUs = 'Call us';
  static const String callUsSub = '+965 22289969';
  static const String emailUs = 'Email us';
  static const String emailUsSub = 'Contact@bnchrplus.com';
  static const String chatUs = 'Chat with us';
  static const String chatUsSub = 'Open chat widget';
  static const String tc = 'Terms and conditions';
  static const String pp = 'Privacy Policy';

  // notification
  static const String notification = 'Notifications';
}
