import 'dart:io';

import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future navPush({required BuildContext context, required Widget widget}) {
  if (Platform.isIOS) {
    return Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => widget));
  } else {
    return Navigator.of(context).push(createRoute(screen: widget));
  }
}

void navPushWithNavigator({required Widget widget}) {
  navigatorKey.currentState?.push(
    MaterialPageRoute(builder: (context) => widget),
  );
}

navPop({required BuildContext context, var data}) {
  Navigator.of(context).pop(data);
}

navPushReplacement({required BuildContext context, required Widget widget}) {
  if (Platform.isIOS) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => widget));
  } else {
    Navigator.of(context).pushReplacement(createRoute(screen: widget));
  }
}

navPushAndRemove({required BuildContext context, required Widget widget}) {
  if (Platform.isIOS) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );
  } else {
    Navigator.of(
      context,
    ).pushAndRemoveUntil(createRoute(screen: widget), (route) => false);
  }
}

// goLogin(BuildContext context) {
//   errorSnackBar(context, getTranslated('please_login', context));
//   navGo(context: context, widget: SignInScreen());
// }

Route createRoute({required Widget screen}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
