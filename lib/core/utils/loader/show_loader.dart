import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../constants/string_define.dart';
import 'loader_widget.dart';

class AppLoader {

  static final AppLoader _singleton = AppLoader._internal();
  factory AppLoader() {
    return _singleton;
  }
  AppLoader._internal();

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: PopScope(
          canPop: false,
          child: Container(
            color: Colors.black.withValues(alpha: 0.2),
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(Platform.isAndroid)
                    Card(
                      margin: EdgeInsets.only(bottom: 10),
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      child: Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset(AppString.logo,color: AppColors.whiteColor,),
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                      height: 42,
                                      width: 42,
                                      child: CircularProgressIndicator(color: AppColors.whiteColor,strokeWidth: 2,strokeCap: StrokeCap.round,))
                              ),
                            ],
                          )),
                    )
                  else
                    CupertinoActivityIndicator(color: AppColors.whiteColor,radius: 10,),

                  // BuildText.buildText(text: "Loading... Please Wait",color: isDataLoad ? AppColors.blackColor : AppColors.whiteColor,fontFamily: FontFamily.interRegular)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
