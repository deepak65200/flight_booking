import 'package:flutter/material.dart';
import '../utils/asset_res.dart';
import '../utils/color_res.dart';

GestureDetector buildBounceGesDetector({
  required Widget child,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 110),
      child: child,
    ),
  );
}

Widget commonHt({required double height}) => SizedBox(height: height);

Widget commonWt({required double width}) => SizedBox(width: width);

Widget commonHorizontalPadding({
  double? left,
  double? right,
  double? top,
  double? bottom,
  required Widget child,
}) => Padding(
  padding: EdgeInsets.only(
    left: left ?? 16,
    right: right ?? 16,
    top: top ?? 0,
    bottom: bottom ?? 0,
  ),
  child: child,
);


Widget commonButton(
    BuildContext context, {
      required VoidCallback onPressed,
      required String label,
      bool isDisabled = false,
      Color backgroundColor = ColorRes.primaryDark,
      Color downBorderColor = Colors.transparent,
      Color? textColor,
      EdgeInsets? padding,
      BorderSide border = BorderSide.none,
      double? width = double.infinity,
      double? height = 48,
      double? textFontSize = 14.0,
      double? borderRadius = 13,
      Widget? prefix,
      Widget? suffix,
      Color? borderColor,
      TextAlign? textAlignment,
      EdgeInsets? margin,
    }) {
  return Padding(
    padding: margin ?? padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      padding: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: downBorderColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 13),
        border: Border.all(color: borderColor ?? Colors.transparent),
      ),
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: isDisabled
                ? [
              backgroundColor.withValues(alpha: 0.8),
              backgroundColor.withValues(alpha:0.1),
            ]
                : [
              //backgroundColor.withValues(alpha:0.8),
              ColorRes.primaryLight,
              backgroundColor,

            ],
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        child: ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, //  IMPORTANT
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 12),
              side: border,
            ),
            padding: EdgeInsets.zero,
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (prefix != null) ...[
                  prefix,
                  if (textAlignment == TextAlign.start)
                    const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    label,
                    textAlign: textAlignment ?? TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: textFontSize ?? 14,
                      fontWeight: FontWeight.w600,
                      color: isDisabled
                          ? Colors.white54
                          : textColor ?? Colors.white,
                    ),
                  ),
                ),
                if (suffix != null) suffix,
              ],
            ),
          ),
        ),
      ),
    ),
  );
}


commonDivider({double? width,double? height, Color? color}) => Container(
  height:height?? 0.88,
  color: color ?? ColorRes.black.withValues(alpha: 0.1),
);


String removeWhiteSpace(TextEditingController controller) {
  return controller.text.toString().trimRight();
}

hideKeyboardFun(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

commonNoDataFound(BuildContext context, {String? title, double? height}) {
  return SizedBox(
    height:
        MediaQuery.of(context).size.height -
        (height ?? 200),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AssetRes.noDataImg, height: 120),
          commonHt(height: 10),
          Text(
            title ?? '',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}



















