
import 'package:flutter/material.dart';
import 'color.dart';
import 'font_family.dart';

class TextStyleCustom{
  TextStyleCustom._privateConstructor();
  static final TextStyleCustom instance = TextStyleCustom._privateConstructor();

  static TextStyle normalStyle({double? fontSize,Color? color,String? fontFamily}){
    return TextStyle(
      fontSize: fontSize ?? 14.0,
      color: color ?? AppColors.blackColor,
      fontFamily: fontFamily ?? FontFamily.medium,
      // height: height ?? 0,
    );
  }

  static TextStyle headingStyle({double? fontSize,Color? color,String? fontFamily}){
    return TextStyle(
      fontSize: fontSize ?? 25.0,
      color: color ?? AppColors.blackColor,
      fontFamily: fontFamily ?? FontFamily.bold,
      height: 1.3,
    );
  }

  static TextStyle textFieldStyle({double? fontSize,Color? color,String? fontFamily}){
    return TextStyle(
      fontSize: fontSize ?? 14.0,
      color: color ?? AppColors.blackColor,
      fontFamily: fontFamily ?? FontFamily.medium,
    );
  }

  static TextStyle underLineStyle(){
    return const TextStyle(
      fontSize: 22.0,
      shadows: [
        Shadow(
          color: Colors.red,
          offset: Offset(0, -5),
        )
      ],
      color: Colors.transparent,
      fontWeight: FontWeight.w900,
      decoration: TextDecoration.underline,
      decorationColor: Colors.red,
      decorationThickness: 1,
    );
  }

}
