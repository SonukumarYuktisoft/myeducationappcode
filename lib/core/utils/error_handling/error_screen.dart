import 'package:flutter/material.dart';
import '../../constants/color.dart';
import '../../constants/font_family.dart';
import '../text.dart';

class ErrorScreen extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? buttonText;
  final Function()? onTap;
  const ErrorScreen({super.key, this.title,this.subTitle,this.buttonText,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(AppString.error,height: 150),
          buildSizeBox(10.0, 0.0),
          BuildText.buildText(text: title ?? "Something went wrong",size: 22,fontFamily: FontFamily.bold),
          buildSizeBox(5.0, 0.0),
          TextButton(onPressed: onTap, child: BuildText.buildText(text: buttonText ?? "Retry",size: 15,fontFamily: FontFamily.medium,color: AppColors.primaryColor))
        ],
      ),
    ),
    );
  }
}