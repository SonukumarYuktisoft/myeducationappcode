// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
// import '../../core/constants/color.dart';
// import '../../core/constants/font_family.dart';
// import '../../core/constants/string_define.dart';
// import '../../core/utils/button.dart';
// import '../../core/utils/text.dart';
// import '../../view/chat/chat_screen.dart';
// import '../../view/drive/drive_list_screen.dart';
// import '../../view/profile/profile_screen.dart';
//
// class DashboardController extends GetxController {
//   int pageIndex = 0;
//   var scaffold = GlobalKey<ScaffoldState>();
//
//   late PersistentTabController bottomBarController;
//
//   @override
//   void onInit(){
//     bottomBarController = PersistentTabController(initialIndex: 1);
//     super.onInit();
//   }
//
//   List<Widget> screens = [
//     ChatScreen(),
//     DriveListScreen(),
//     ProfileScreen(isFromRegister: false)
//   ];
//
//   void changePageIndex(int index) {
//     bottomBarController.index = index;
//     update();
//   }
//
//   final List<PersistentBottomNavBarItem> navItems = [
//     PersistentBottomNavBarItem(
//       icon: SvgPicture.asset(AppString.chatSvg,
//           colorFilter: ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn)),
//       inactiveIcon: SvgPicture.asset(AppString.chatSvg,
//           colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
//       title: 'Chat',
//       activeColorPrimary: AppColors.primaryColor,
//       activeColorSecondary: AppColors.whiteColor,
//       inactiveColorPrimary: Colors.grey,
//       textStyle: TextStyle(color: AppColors.whiteColor,
//           fontSize: 14,
//           fontFamily: FontFamily.medium),
//     ),
//     PersistentBottomNavBarItem(
//         icon: SvgPicture.asset(AppString.carSvg,
//             colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)),
//         inactiveIcon: SvgPicture.asset(AppString.carSvg,
//             colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
//         title: 'Create Drive  ',
//         activeColorPrimary: AppColors.primaryColor,
//         activeColorSecondary: AppColors.whiteColor,
//         inactiveColorPrimary: Colors.grey,
//         textStyle: TextStyle(color: AppColors.whiteColor,
//             fontSize: 14,
//             fontFamily: FontFamily.medium)
//     ),
//     PersistentBottomNavBarItem(
//         icon: SvgPicture.asset(AppString.profileSvg,
//             colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)),
//         inactiveIcon: SvgPicture.asset(AppString.profileSvg,
//             colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
//         title: 'Profile',
//         activeColorPrimary: AppColors.primaryColor,
//         activeColorSecondary: AppColors.whiteColor,
//         inactiveColorPrimary: Colors.grey,
//         textStyle: TextStyle(color: AppColors.whiteColor,
//             fontSize: 14,
//             fontFamily: FontFamily.medium)
//     )
//   ];
//
//   Future<bool> onExitApp()async{
//     return await Get.dialog(
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25),
//         child: SizedBox(
//           width: Get.width,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: AppColors.clr2C2C2C,
//                     border: Border.all(color: AppColors.clr606060),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 25),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         buildSizeBox(35.0, 0.0),
//                         SvgPicture.asset(AppString.warning),
//                         buildSizeBox(25.0, 0.0),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: BuildText.buildText(text: 'Are you sure you want to exit the app?',
//                               size: 20,
//                               fontFamily: FontFamily.regular,
//                               color: AppColors.whiteColor,
//                               textAlign: TextAlign.center),
//                         ),
//                         buildSizeBox(25.0, 0.0),
//
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: CustomButton(
//                                 onPressed: () => Navigator.pop(Get.context!),
//                                 text: "No",
//                                 btnHeight: 42,
//                                 borderWidth: 1,
//                                 color: Colors.transparent,
//                                 borderColor: AppColors.primaryColor,
//                                 textStyle: TextStyle(fontSize: 18, fontFamily: FontFamily.regular,color: AppColors.whiteColor,decoration: TextDecoration.none),
//                               ),
//                             ),
//                             buildSizeBox(0.0, 20.0),
//                             Expanded(
//                               child: Card(
//                                 elevation: 4,
//                                 color: AppColors.clr2C2C2C,
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                                 margin: EdgeInsets.zero,
//                                 child: CustomButton(
//                                   onPressed: () => SystemNavigator.pop(),
//                                   text: "Yes",
//                                   btnHeight: 42,
//                                   isGradient: false,
//                                   color: AppColors.clrE53935,
//                                   textStyle: TextStyle(fontSize: 18, fontFamily: FontFamily.semiBold),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         buildSizeBox(20.0, 0.0),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//     ) ?? false;
//   }
// }