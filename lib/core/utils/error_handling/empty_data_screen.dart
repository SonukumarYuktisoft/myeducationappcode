import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../constants/font_family.dart';
import '../text.dart';

class EmptyDataScreen extends StatelessWidget {
  final String title;
  final String? subTitle;
  const EmptyDataScreen({super.key,required this.title,this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(AppString.emptyData,height: 150),
          buildSizeBox(10.0, 0.0),
          BuildText.buildText(text: title,size: 22,fontFamily: FontFamily.bold),
          buildSizeBox(5.0, 0.0),
          BuildText.buildText(text: subTitle ?? "",size: 16,fontFamily: FontFamily.regular,color: AppColors.whiteColor),
        ],
      ),
    ),
    );
  }
}