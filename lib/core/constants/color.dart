import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _singleton = AppColors._internal();
  factory AppColors() {
    return _singleton;
  }
  AppColors._internal();

  static Color themeColor = Colors.deepOrangeAccent;
  static Color loaderColor = Colors.deepOrangeAccent;
  static Color greyColor = Colors.grey;
  // static Color blackColor = Colors.black;

  // static Color primaryColor = const Color(0xFFF8A340);
  static Color primaryColor = const Color(0xFF39895F);
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color clr373737 = const Color(0xFF373737);
  static Color clr222222 = const Color(0xFF222222);
  static Color clr2C2C2C = const Color(0xFF2C2C2C);
  static Color clrD6D6D6 = const Color(0xFFD6D6D6);
  static Color clr606060 = const Color(0xFF606060);
  static Color clrFF3B30 = const Color(0xFFFF3B30);
  static Color clrC8C7CC = const Color(0xFFC8C7CC);
  static Color clr2F2F2F = const Color(0xFF2F2F2F);
  static Color clrD1DEE8 = const Color(0xFFD1DEE8);
  static Color clr8D8D8D = const Color(0xFF8D8D8D);
  static Color clrE53935 = const Color(0xFFE53935);
  static Color blackColor = Colors.black;

  /// Text-field
  static Color textFieldActiveBorderColor = const Color(0xFFFFD800);
  static Color textFieldErrorBorderColor = const Color(0xFFCB2A2F);
  static Color textFieldBackgroundColor = Colors.grey.shade300;
  static Color redColor = Color(0xffEF4444);
  static Color textFieldBorderColor = Colors.transparent;
  static Color textFieldHintTextColor = Colors.grey.shade700;
  static Color textFieldTextColor = Colors.white;
  static Color searchTextfieldTextColor = const Color(0xff949494);
  static Color dividerColor = const Color(0xffDFDFDF);

  static LinearGradient linearButtonColor = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xff39895F), Color(0xff44755B)],
  );

  static LinearGradient inActiveButtonGradientColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff4FBAFD).withValues(alpha: 0.5),
      Color(0xff1E3FF0).withValues(alpha: 0.5),
    ],
  );
}

/// Color Extension
extension ColorExtension on String {
  toColor() {
    var hexStringColor = this;
    final buffer = StringBuffer();

    if (hexStringColor.length == 6 || hexStringColor.length == 7) {
      buffer.write('ff');
      buffer.write(hexStringColor.replaceFirst("#", ""));
      return Color(int.parse(buffer.toString(), radix: 16));
    }
  }
}
