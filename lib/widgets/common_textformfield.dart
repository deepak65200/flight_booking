import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helpers/responsive_helper.dart';
import '../utils/color_res.dart';
import '../utils/common_res.dart';

final emailPattern = RegExp(
  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
);

Widget commonTextField({
  required BuildContext context,
  Function(String? value)? onChanged,
  FocusNode? focusNode,
  bool autoFocus = false,
  required TextEditingController controller,
  required String title,
  String? hintText,
  TextStyle? hintTextStyle,
  TextInputType? keyboardType,
  final TextInputAction? textInputAction,
  List<TextInputFormatter>? inputFormatters,
  Widget? suffix,
  Widget? preffix,
  bool isRead = false,
  bool obscureText = false,
  double? width,
  double? height,
  bool isMandatory = true,
  int length = 256,
  RegExp? textRegex,
  int? maxLines = 1,
  Function()? onTap,
  double borderWidth = 1.0,
  EdgeInsets padding = EdgeInsets.zero,
  final TextAlign? textAlign,
  final InputDecoration? decoration,
  final TextStyle? textStyle,
  Color backgroundColor = ColorRes.white,
  double? suffixWidth,
  TextCapitalization textCapitalization =
      TextCapitalization.none,
  Color? cursorColor,
  String? tag,
  bool isBorder = true,
  bool isLabel = true,
  bool showCounter = false,
  Color? borderColor,
  EdgeInsets? contentPadding,
  String? Function(String?)? validator,

}) {
  return SizedBox(
    height: height,
    width: width ?? ResponsiveHelper.getWidth(context),
    child: TextFormField(
    scrollPadding: EdgeInsets.only(
    bottom: MediaQuery.of(context).viewInsets.bottom),
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.start,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters ?? [],
      textCapitalization: textCapitalization,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.done,
      controller: controller,
      cursorColor:cursorColor?? ColorRes.black,
      focusNode: focusNode,
      autofocus: autoFocus,
      readOnly: isRead,
      obscureText: obscureText,
      maxLength: length,
      obscuringCharacter: '●',
      onChanged: onChanged ?? (value) {},
      style:
          textStyle ??
          TextStyle(
            color: ColorRes.black,
            fontSize: TextSizeRes.xiv,
            fontFamily: FontRes.montserratSemiBold,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2,
          ),

        validator: validator ?? (value) {
        if (isMandatory) {
          if ((tag != 'signUp' || title != 'Mobile Number') && value!.isEmpty) {
            return '$title can\'t be empty';
          } else if (((tag != 'signUp' ||
                          title != 'Mobile Number' ||
                          value!.isNotEmpty) &&
                      title == 'Mobile Number' ||
                  title == 'Phone Number' ||
                  title=='Enter Mobile Number or Email ID'||
                  title == 'Alternative Mobile Number') &&
              value!.length < 9) {
            return 'Please enter valid mobile number';
          } else if ((title == 'Email Address (Optional)' ||
                  title == 'Your email') &&
              !ValidationUtils.isValidEmail(value.toString())) {
            return 'Please enter valid Email';
          }
          else if ((title == 'Email ID' ||
              title == 'Email ID') &&
              !ValidationUtils.isValidEmail(value.toString())) {
            return 'Please enter valid Email';
          }else if (title == 'Enter PAN Number' &&
              !ValidationUtils.isValidPan(value.toString())) {
            return 'Please enter valid PAN (e.g. AAAPA1234A)';
          }else if ((title == 'Password' || title == 'Confirm Password') &&
              value!.length < 6) {
            return '$title should be minimum 6 characters';
          } else if (textRegex != null) {
            if (!textRegex.hasMatch(value!)) {
              return 'Please enter valid ${title.toLowerCase()}';
            }
            return null;
          } else {
            return null;
          }
        } else {
          if (value!.isNotEmpty && textRegex != null) {
            if (textRegex != null) {
              if (!textRegex.hasMatch(value)) {
                return 'Please enter valid ${title.toLowerCase()}';
              }
              return null;
            }
          }
          return null;
        }
      },
      onTap: onTap,
      decoration:
          decoration ??
          InputDecoration(
            counter: showCounter? Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  '${controller.text.length.toString()} / $length',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ) : null,
            prefixIcon:
                preffix != null
                    ? Padding(padding: padding, child: preffix)
                    : null,
            fillColor: backgroundColor,
            filled: true,
            counterText: '',
            labelText:
                (tag != 'noLabel' &&
                        tag != "signUp" &&
                        tag != 'KYC' &&
                        tag != 'noLabel' &&
                    tag != 'Search Location' &&
                        tag != 'signIn') && isLabel
                    ? title
                    : null,
            hintText:
                (tag != "signUp" || title.toString() == 'Mobile Number'|| !isMandatory)
                    ? hintText ?? title
                    : hintText ?? '$title*',
            labelStyle: const TextStyle(
              color: ColorRes.black, // Change the color here
              fontSize: TextSizeRes.xiv,
              fontFamily: FontRes.montserratSemiBold,
              fontWeight: FontWeight.w400,
            ),
            hintStyle:  hintTextStyle??TextStyle(
              color: ColorRes.black,
              fontSize: TextSizeRes.xiv,
              fontFamily: FontRes.montserratSemiBold,
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: borderWidth,
                color:
                  (tag == 'Search Location') ||
                  (tag == 'Search') || !isBorder//||(tag == 'car')
                  ? ColorRes.white: borderColor??ColorRes.primaryLight.withValues(alpha: 0.5),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: borderWidth,
                color:
                  (tag == 'Search Location') ||
                  (tag == 'Search') || !isBorder//||(tag == 'car')
                  ? ColorRes.white:
                borderColor??ColorRes.black.withValues(alpha: 0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: borderWidth,
                color:
                  (tag == 'Search Location') ||
                  (tag == 'Search') || !isBorder//||(tag == 'car')
                  ? ColorRes.white:ColorRes.black.withValues(alpha: 0.5),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: borderWidth,
                color:
                  (tag == 'Search Location') ||
                  (tag == 'Search') || !isBorder//||(tag == 'car')
                  ? ColorRes.white:
                borderColor??ColorRes.black.withValues(alpha: 0.5),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: borderWidth, color: isBorder? ColorRes.redColor.withValues(alpha: 0.5) : Colors.transparent),
            ),
            suffixIcon:
                (suffix != null && tag == 'signUp' &&title=='Mobile Number'|| title == 'Email Address (Optional)'||title=='DOB'||title == 'Enter Old Password'||title == 'Password'||title=='Enter New Password' ||title=='Confirm Password'
                    ||title=='Address')
                    ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 30,
                        width: suffixWidth ?? 60,
                        child: suffix,
                      ),
                    )
                    : null,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: borderWidth, color: isBorder?ColorRes.redColor.withValues(alpha: 0.5) : Colors.transparent),
            ),
            contentPadding: contentPadding??const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 16.0,
            ),
          ), // Adjust content padding
    ),
  );
}

class DateInputFormatter2 extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Prevent deleting characters
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    // Only allow numeric input and slashes
    final regExp = RegExp(r'^\d{0,2}/?\d{0,2}/?\d{0,4}$');
    if (!regExp.hasMatch(newValue.text)) {
      return oldValue;
    }

    // Automatically insert slashes at the appropriate positions
    String newText = newValue.text;
    if (newText.length == 2 || newText.length == 5) {
      newText += '/';
    }

    // Return the new value with the updated text
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Prevent deleting characters
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    // Only allow numeric input and hyphens
    final regExp = RegExp(r'^\d{0,4}-?\d{0,2}-?\d{0,2}$');
    if (!regExp.hasMatch(newValue.text)) {
      return oldValue;
    }

    // Automatically insert hyphens at the appropriate positions
    String newText = newValue.text;
    if (newText.length >= 5 && newText[4] != '-') {
      newText = '${newText.substring(0, 4)}-${newText.substring(4)}';
    }
    if (newText.length >= 8 && newText[7] != '-') {
      newText = '${newText.substring(0, 7)}-${newText.substring(7)}';
    }

    // Return the new value with the updated text
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
