//
// import 'dart:io';
// import 'package:drive_mate/core/constants/font_family.dart';
// import 'package:drive_mate/core/utils/text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../constants/color.dart';
// class BottomSheetCustom{
//
//   static final BottomSheetCustom _singleton = BottomSheetCustom._internal();
//   factory BottomSheetCustom() {
//     return _singleton;
//   }
//   BottomSheetCustom._internal();
//
//   static showDynamicBottomSheet({required BuildContext context ,required Widget child ,required Function(dynamic) onValue,required AnimationController animationController}) async {
//     return await showModalBottomSheet(
//         useSafeArea: true,
//         enableDrag: false,
//         barrierColor: Colors.transparent,
//         isDismissible: false,
//         transitionAnimationController: animationController,
//         isScrollControlled: true,
//         clipBehavior: Clip.antiAlias,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               topRight: Radius.circular(24.0),
//               topLeft: Radius.circular(24.0),
//             )
//         ),
//         context: context,
//         backgroundColor: AppColors.clr2C2C2C,
//         builder: (builder){
//           return
//             Wrap(
//               children: [
//                 SafeArea(child: child)
//               ],
//             );
//         }
//     ).then(onValue);
//   }
//
//   static showImagePickerBottomSheet({required BuildContext context,required Function(dynamic) onValue}) {
//     showModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       isDismissible: true,
//       context: context,
//       builder: (BuildContext context) {
//         return Wrap(
//           children: [
//             SafeArea(
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                       bottom: Platform.isIOS ? 15.0 : 0.0),
//                   child: Column(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 15),
//                         width: Get.width,
//                         decoration: BoxDecoration(
//                             color: Colors.grey.shade200,
//                             borderRadius: BorderRadius.circular(15)
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               InkWell(
//                                   onTap: () =>
//                                       Navigator.of(context).pop("camera"),
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 8),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment
//                                           .center,
//                                       children: [
//                                         BuildText.buildText(text: "Camera",
//                                             color: Colors.blue,
//                                             fontFamily: FontFamily.semiBold,
//                                             size: 15),
//                                       ],
//                                     ),
//                                   )),
//                               Divider(color: Colors.grey.shade500),
//                               InkWell(
//                                   onTap: () =>
//                                       Navigator.of(context).pop("gallery"),
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 8),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment
//                                           .center,
//                                       children: [
//                                         BuildText.buildText(text: "Gallery",
//                                             color: Colors.blue,
//                                             fontFamily: FontFamily.semiBold,
//                                             size: 15),
//                                       ],
//                                     ),
//                                   )),
//                             ],
//                           ),
//                         ),
//                       ),
//                       buildSizeBox(15.0, 0.0),
//
//                       InkWell(
//                         onTap: () => Get.back(),
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 15),
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               color: Colors.grey.shade200,
//                               borderRadius: BorderRadius.circular(30)
//                           ),
//                           child: BuildText.buildText(text: "Cancel",
//                               color: AppColors.redColor,
//                               weight: FontWeight.w600,
//                               size: 15),
//                         ),
//                       ),
//                       Platform.isAndroid
//                           ? buildSizeBox(20.0, 0.0)
//                           : const SizedBox.shrink(),
//                     ],
//                   ),
//                 )
//             ),
//           ],
//         );
//       }).then(onValue);
//   }
//   }
