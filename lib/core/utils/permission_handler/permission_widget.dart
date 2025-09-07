
import 'package:flutter/material.dart';

import '../../constants/font_family.dart';


class PermissionHandlerWidget{

  /// Latter Spacing
  static double latterSpacing = 0.4;

  /// Color
  static Color themeColor = Colors.deepPurple;
  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;
  static Color headingColor = Colors.black;
  static Color titleColor = Colors.black;
  static Color subTitleColor = Colors.black38;
  static Color errorColor = Colors.red;
  static Color greenColor = Colors.green;
  static Color greyColor = Colors.grey.withValues(alpha:0.3);

  /// String
  static String kAllow = "Allow";
  static String kPermission = "Permission";
  static String kLocation = "Location";
  static String kCamera = "Camera";
  static String kMicrophone = "Microphone";
  static String kSMS = "SMS";
  static String kOk = "Ok";
  static String kPhotosAndMedia = "Photos & Media";
  static String kTitle = "Allow app permissions";
  static String kDoNotAllow = "Don't Allow";
  static String kSubTitle = "Allow permission for personalised experience";
  static String kAllMandateTitle = "Your Data is safe. All permissions are mandatory.";

  static String kCameraPermissionSubtitle = "We need camera access for the app's functionality, which enables you to capture profile image";
  static String kLocationPermissionSubtitle = "We need your location permission to help you discover nearby animals, log or upload new animal sightings, and display them on the map based on their upload location. Rest assured, your location data is used only for these purposes and is securely processed in compliance with privacy standards.";
  static String kMicroPhonePermissionSubtitle = "We need microphone access for using camera functionality.";
  static String kPhotosAndMedianPermissionSubtitle = "We need gallery access for the app's functionality, which enables you to upload your profile picture";



  static Widget bottomNavigationStyle({
    String? title,
    required void Function() onPressed,
    Color? titleColor,
    double? titleSize,
    double? elevation,
    double? minWidth,
    double? height,
    Color? bgColor,
    Color? splashColor,
    double? radius,
  }){
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radius ?? 0.0))),
      elevation: elevation ?? 10.0,
      minWidth: minWidth ?? 200.0,
      height: height ?? 50,
      highlightColor: bgColor ?? titleColor ?? Colors.blue,
      splashColor: splashColor ?? titleColor ?? Colors.deepOrange,


      color: bgColor ?? titleColor ?? Colors.blue,
      onPressed: onPressed,
      child: Text(title ?? 'Next',style: TextStyle(fontSize: titleSize ?? 18.0,fontWeight: FontWeight.w700, color: titleColor ?? Colors.black)),
    );
  }

  static Widget listWidget({required BuildContext context,required Widget leading,required String title,required String subTitle,required bool checkBoxValue, required Function() onTap}){
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(right: 10,top: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: greyColor
              ),
              child: Center(
                child: leading,
              ),
            ),

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          title
                          ,style: TextStyle(color:  checkBoxValue ? titleColor:errorColor,fontFamily: FontFamily.bold,fontSize: 18,letterSpacing: latterSpacing)
                      ),

                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: checkBoxValue ? greenColor:whiteColor
                        ),
                        padding: checkBoxValue ? const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2): EdgeInsets.zero,
                        child: FittedBox(
                            child: checkBoxValue ? Icon(Icons.check,color: whiteColor):Icon(Icons.error,color: errorColor)
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Text(
                        subTitle
                        ,style: TextStyle(color: subTitleColor,fontFamily: FontFamily.regular,fontSize: 13,letterSpacing: latterSpacing),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}