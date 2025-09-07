import 'package:education/core/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/color.dart';
import '../constants/font_family.dart';
import '../constants/string_define.dart';

class CustomAppBar{

  static AppBar appBar({bool? showBackBtn,Color? backgroundColor,bool? centerTitle,double? elevation,double? leadingWidth,String? title, Color? titleColor,double? fontSize,VoidCallback? onTap, Color? leadingColor, Widget? action1, Widget? action2,Color? backButtonColor, Widget? leading,String? fontFamily}){
    return AppBar(
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 60,
      title: BuildText.buildText(text: title?.tr ?? '',style: TextStyle(color: titleColor ?? AppColors.whiteColor,fontSize: fontSize ?? 18,fontFamily: fontFamily ?? FontFamily.bold)),
      leading: leading ?? Visibility(
        visible: showBackBtn ?? true,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: onTap ?? () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 6),
            child: SvgPicture.asset(AppString.arrowBack),
          )
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              action1 ?? const SizedBox.shrink(),
              buildSizeBox(0.0, 10.0),
              action2 ?? const SizedBox.shrink()
            ],
          ),
        )
      ],
      leadingWidth: leadingWidth ?? 48,
      elevation: elevation ?? 0,
      centerTitle: centerTitle ?? true,
      backgroundColor: backgroundColor ?? Colors.transparent,
    );
  }
  
}