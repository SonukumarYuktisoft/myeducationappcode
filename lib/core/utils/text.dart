
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/color.dart';
import '../constants/font_family.dart';

class BuildText{

  static Widget buildText({required
  String text,
    TextStyle? style,
    TextDecoration?decoration,
    String?fontFamily,
    double? size,
    double? height,
    FontWeight? weight,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Color? textDecorationColor,
    double? letterSpacing}){
    return Text(
      text,
      style: style ?? TextStyle(
        decoration: decoration ?? TextDecoration.none,
        decorationColor: textDecorationColor ?? AppColors.whiteColor,
        decorationThickness: 1,
        fontFamily: fontFamily ?? FontFamily.regular,
        fontSize: size ?? 14,
        fontWeight: weight,
        height: height,
        color: color ?? AppColors.blackColor,
        letterSpacing: letterSpacing ?? 0.0
      ),
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
      maxLines: maxLines,
    );
  }



}


Widget buildSizeBox(height,width){
  return SizedBox(height: height, width: width,);
}

Widget buildSizeBoxRatio(height,width) {
  return SizedBox(
    height: Get.height * height.toDouble()/100,
    width:Get.width * width.toDouble()/100,
  );
}
double getHeightRatio({required double value}) {
  return Get.height * value.toDouble()/100;
}

double getWidthRatio({required double value}) {
  return Get.width * value.toDouble()/100;
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}
