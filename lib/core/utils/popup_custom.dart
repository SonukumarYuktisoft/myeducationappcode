import 'dart:ui';
import 'package:education/core/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../constants/color.dart';
import '../constants/font_family.dart';
import '../constants/string_define.dart';
import 'button.dart';

class PopupCustom {
  PopupCustom._privateConstructor();
  static final PopupCustom instance = PopupCustom._privateConstructor();

  static blockPopUp({
    required Function(dynamic) onValue,
  }){
    return showGeneralDialog(
      barrierColor: AppColors.blackColor.withValues(alpha: 0.7),
      barrierDismissible: true,
      barrierLabel: "",
      context: Get.context!,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return SizedBox(
          width: Get.width,
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.clr2C2C2C,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildSizeBox(25.0, 0.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: BuildText.buildText(text: "You blocked Sophia Bennett",size: 18,fontFamily: FontFamily.bold,color: AppColors.whiteColor,textAlign: TextAlign.center),
                            ),
                            buildSizeBox(20.0, 0.0),
                    
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 4,
                                  width: 4,
                                  margin: EdgeInsets.only(top: 9),
                                  decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.whiteColor),
                                ),
                                buildSizeBox(0.0, 10.0),
                                Expanded(child: BuildText.buildText(text: "They won't be able to contact you or view your profile."))
                              ],
                            ),
                            buildSizeBox(8.0, 0.0),
                    
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 4,
                                  width: 4,
                                  margin: EdgeInsets.only(top: 9),
                                  decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.whiteColor),
                                ),
                                buildSizeBox(0.0, 10.0),
                                Expanded(child: BuildText.buildText(text: "Sophia will be added to your block lists"))
                              ],
                            ),
                            buildSizeBox(8.0, 0.0),
                    
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 4,
                                  width: 4,
                                  margin: EdgeInsets.only(top: 9),
                                  decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.whiteColor),
                                ),
                                buildSizeBox(0.0, 10.0),
                                Expanded(child: BuildText.buildText(text: "You can unblock them anytime in your profile."))
                              ],
                            ),
                            buildSizeBox(20.0, 0.0),
                    
                            CustomButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              text: "Yes, Block Sophia",
                              textStyle: TextStyle(fontSize: 16,fontFamily: FontFamily.regular),
                            ),
                            buildSizeBox(20.0, 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  buildSizeBox(15.0, 0.0),
                  CustomButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    text: "Cancel",
                    btnHeight: 34,
                    btnWidth: 100,
                    color: AppColors.whiteColor,
                    isGradient: false,
                    textStyle: TextStyle(fontSize: 14,fontFamily: FontFamily.semiBold,color: AppColors.blackColor),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).then(onValue);
  }

  static logoutOrDeletePopUp({
    required String title,
    String? alertText,
    required Function(dynamic) onValue,
  }){
    return showGeneralDialog(
      barrierColor: AppColors.blackColor.withValues(alpha: 0.7),
      barrierDismissible: true,
      barrierLabel: "",
      context: Get.context!,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return SizedBox(
          width: Get.width,
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.clr2C2C2C,
                        border: Border.all(color: AppColors.clr606060),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildSizeBox(35.0, 0.0),
                            SvgPicture.asset(AppString.warning),
                            buildSizeBox(25.0, 0.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: BuildText.buildText(text: title,size: 20,fontFamily: FontFamily.regular,color: AppColors.whiteColor,textAlign: TextAlign.center),
                            ),
                            buildSizeBox(25.0, 0.0),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    text: "No",
                                    btnHeight: 42,
                                    borderWidth: 1,
                                    color: Colors.transparent,
                                    borderColor: AppColors.primaryColor,
                                    textStyle: TextStyle(fontSize: 18,fontFamily: FontFamily.regular),
                                  ),
                                ),
                                buildSizeBox(0.0, 20.0),
                                Expanded(
                                  child: Card(
                                    elevation: 4,
                                    color: AppColors.clr2C2C2C,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    margin: EdgeInsets.zero,
                                    child: CustomButton(
                                      onPressed: () => Navigator.of(context).pop(true),
                                      text: "Yes",
                                      btnHeight: 42,
                                      isGradient: false,
                                      color: AppColors.clrE53935,
                                      textStyle: TextStyle(fontSize: 18,fontFamily: FontFamily.regular),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            buildSizeBox(20.0, 0.0),

                            if(alertText != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: BuildText.buildText(text: alertText,color: AppColors.clrE53935),
                            ),
                            buildSizeBox(20.0, 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).then(onValue);
  }

  // static photoViewPopUp({ required Function(dynamic) onValue,required BuildContext context,required String image,required VoidCallback onTapDownloadImage, bool? isLoadingImage}){
  //   return Get.dialog(
  //     barrierDismissible: true,
  //     AlertDialog(
  //         contentPadding: const EdgeInsets.symmetric(vertical: 10),
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //         backgroundColor: Colors.transparent,
  //         surfaceTintColor: Colors.transparent,
  //         content: BackdropFilter(
  //           filter:  ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
  //           child:  Container(
  //               height: 350,
  //               width: Get.width,
  //               clipBehavior: Clip.antiAlias,
  //               decoration: BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 color: Colors.transparent,),
  //               child: PhotoView(
  //                   maxScale: 1.0,
  //                   minScale: 0.6,
  //                   filterQuality: FilterQuality.high,
  //                   imageProvider: CachedNetworkImageProvider(
  //                     image.trim().toString().contains("http") ?
  //                     image : "${ApiUrl.kDomain}$image")
  //               )
  //             // ImageHelperCustom(image: "${ApiUrl.kDomain}${widget.image}", fit: BoxFit.cover)
  //
  //           ),
  //         ))).then(onValue);
  // }

// static cupertinoCustomDialog({required Function(dynamic) onValue, required String title,required String description, required String primaryButtonText,required String secondaryButtontext,bool? showImage}){
//   return Get.dialog(
//     barrierDismissible: false,
//     SizedBox(
//       width: MediaQuery.of(Get.context!).size.width * 0.7,
//       child: AlertDialog(
//         insetPadding: EdgeInsets.symmetric(horizontal: 50),
//         contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//           backgroundColor: Colors.white,
//           surfaceTintColor: Colors.white,
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 15,),
//             (showImage != false) ?
//             Icon(Icons.exit_to_app_rounded,size: 40) : SizedBox.shrink(),
//             const SizedBox(height: 15,),
//             BuildText.buildText(text: title,fontFamily: FontFamily.interBold,size: 17,textAlign: TextAlign.center),
//             const SizedBox(height: 30,),
//             BuildText.buildText(text: description,size: 13,textAlign: TextAlign.center),
//             const SizedBox(height: 15,),
//             InkWell(
//               highlightColor: Colors.grey.shade300,
//               splashColor: Colors.grey.shade300,
//               onTap: () => Navigator.of(Get.context!).pop(true),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 7),
//                 alignment: Alignment.center,
//                 width: Get.width,
//                 child: BuildText.buildText(text: primaryButtonText,fontFamily: FontFamily.interMedium,size: 15,color: Colors.blue))
//             ),
//             const Divider(),
//             InkWell(
//               highlightColor: Colors.grey.shade300,
//               splashColor: Colors.grey.shade300,
//               onTap: () => Get.back(),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 7),
//                 alignment: Alignment.center,
//                 width: Get.width,
//                 child: BuildText.buildText(text: secondaryButtontext,fontFamily: FontFamily.interMedium,color: AppColors.redColor,size: 15))),
//           ],
//         ),
//       ),
//     ),
//   ).then(onValue);
// }

}