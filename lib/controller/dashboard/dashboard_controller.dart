import 'dart:ui';
import 'package:education/view/dashboard/chat/chat_screen.dart';
import 'package:education/view/dashboard/home/home_screen.dart';
import 'package:education/view/dashboard/my_course/my_course_screen.dart';
import 'package:education/view/dashboard/profile/profile_screen.dart';
import 'package:education/view/dashboard/test/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../core/constants/color.dart';
import '../../core/constants/font_family.dart';
import '../../core/constants/string_define.dart';
import '../../core/utils/button.dart';
import '../../core/utils/text.dart';

class DashboardController extends GetxController {
  int pageIndex = 0;
  var scaffold = GlobalKey<ScaffoldState>();

  late PersistentTabController bottomBarController;

  @override
  void onInit(){
    bottomBarController = PersistentTabController(initialIndex: 0);
    super.onInit();
  }

  List<Widget> screens = [
    HomeScreen(),
    MyCourseScreen(),
    ChatScreen(),
    MockTestScreen(),
    ProfileScreen()
  ];

  void changePageIndex(int index) {
    bottomBarController.index = index;
    update();
  }

  final List<PersistentBottomNavBarItem> navItems = [
    PersistentBottomNavBarItem(
      contentPadding: 0,
      icon: Icon(Icons.home_filled,color: AppColors.blackColor,),
      inactiveIcon: Icon(Icons.home_filled,color: Colors.grey),
      title: 'Home',
      activeColorPrimary: AppColors.primaryColor,
      activeColorSecondary: AppColors.whiteColor,
      inactiveColorPrimary: Colors.grey,
      textStyle: TextStyle(color: AppColors.blackColor,
          fontSize: 14,
          fontFamily: FontFamily.medium),
    ),
    PersistentBottomNavBarItem(
      contentPadding: 0,
      icon: Icon(Icons.folder_copy_rounded,color: AppColors.blackColor,),
      inactiveIcon: Icon(Icons.folder_copy_rounded,color: Colors.grey),
      title: 'My Course',
      activeColorPrimary: AppColors.primaryColor,
      activeColorSecondary: AppColors.whiteColor,
      inactiveColorPrimary: Colors.grey,
      textStyle: TextStyle(color: AppColors.blackColor,
          fontSize: 14,
          fontFamily: FontFamily.medium),
    ),
    PersistentBottomNavBarItem(
      contentPadding: 0,
      icon: Icon(Icons.chat_bubble,color: AppColors.blackColor,),
      inactiveIcon: Icon(Icons.chat_bubble,color: Colors.grey),
      title: 'Chat',
      activeColorPrimary: AppColors.primaryColor,
      activeColorSecondary: AppColors.whiteColor,
      inactiveColorPrimary: Colors.grey,
      textStyle: TextStyle(color: AppColors.blackColor,
          fontSize: 14,
          fontFamily: FontFamily.medium),
    ),
    PersistentBottomNavBarItem(
      contentPadding: 0,
      icon: Icon(Icons.note_alt_sharp,color: AppColors.blackColor,),
      inactiveIcon: Icon(Icons.note_alt_sharp,color: Colors.grey),
      title: 'Test',
      activeColorPrimary: AppColors.primaryColor,
      activeColorSecondary: AppColors.whiteColor,
      inactiveColorPrimary: Colors.grey,
      textStyle: TextStyle(color: AppColors.blackColor,
          fontSize: 14,
          fontFamily: FontFamily.medium),
    ),
    PersistentBottomNavBarItem(
      contentPadding: 0,
      icon: Icon(Icons.person,color: AppColors.blackColor,),
      inactiveIcon: Icon(Icons.person,color: Colors.grey),
      title: 'Profile',
      activeColorPrimary: AppColors.primaryColor,
      activeColorSecondary: AppColors.whiteColor,
      inactiveColorPrimary: Colors.grey,
      textStyle: TextStyle(color: AppColors.blackColor,
          fontSize: 14,
          fontFamily: FontFamily.medium),
    ),

  ];

  Future<bool> onExitApp()async{
    return await Get.dialog(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildSizeBox(35.0, 0.0),
                        SvgPicture.asset(AppString.warning),
                        buildSizeBox(25.0, 0.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: BuildText.buildText(text: 'Are you sure you want to exit the app?',
                              size: 20,
                              fontFamily: FontFamily.regular,
                              color: AppColors.whiteColor,
                              textAlign: TextAlign.center),
                        ),
                        buildSizeBox(25.0, 0.0),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomButton(
                                onPressed: () => Navigator.pop(Get.context!),
                                text: "No",
                                btnHeight: 42,
                                borderWidth: 1,
                                color: Colors.transparent,
                                borderColor: AppColors.primaryColor,
                                textStyle: TextStyle(fontSize: 18, fontFamily: FontFamily.regular,color: AppColors.whiteColor,decoration: TextDecoration.none),
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
                                  onPressed: () => SystemNavigator.pop(),
                                  text: "Yes",
                                  btnHeight: 42,
                                  isGradient: false,
                                  color: AppColors.clrE53935,
                                  textStyle: TextStyle(fontSize: 18, fontFamily: FontFamily.semiBold),
                                ),
                              ),
                            ),
                          ],
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
      )
    ) ?? false;
  }
}