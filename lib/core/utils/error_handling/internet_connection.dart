import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/color.dart';
import '../../constants/font_family.dart';
import '../button.dart';
import '../permission_handler/connection_validator.dart';
import '../text.dart';
import '../toast.dart';

class ErrorHandling{

  static Widget internetConnection({required Function() onRetry}){
    return Container(
      alignment: Alignment.center,
      height: Get.height,
      width: Get.width,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuildText.buildText(text: "Internet Connection Error",size: 16,fontFamily: FontFamily.regular),
              buildSizeBox(8.0, 0.0),
              CustomButton(
                onPressed: (){
                  ConnectionValidator().check().then((value) {
                    if(value){
                      onRetry();
                    }else{
                      ToastCustom.showSnackBar(subtitle: "Internet service unavailable");
                    }
                  });
                },
                text: "Check Again",
                btnWidth: 110,
                btnHeight: 35,
                borderRadius: 30,
                color: AppColors.primaryColor,
                textStyle: TextStyle(fontSize: 14,fontFamily: FontFamily.medium,color: AppColors.blackColor,decoration: TextDecoration.none),
              ),
            ],
          )
        ],
      ),
    );
  }
}