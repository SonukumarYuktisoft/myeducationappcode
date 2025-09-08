import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../controller/dashboard/dashboard_controller.dart';
import '../../core/constants/color.dart';
import '../../core/constants/font_family.dart';
import '../../core/utils/text.dart';
import '../../main.dart';

class DashboardScreen extends StatelessWidget {
  final int index;

  DashboardScreen({super.key, required this.index});

  final DashboardController ctrl = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: ctrl,
      builder: (controller) {
        return PopScope(
          canPop: false,
          child: Scaffold(
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: PersistentTabView(
                      margin: EdgeInsets.only(top: 10),
                      context,
                      controller: controller.bottomBarController,
                      screens: controller.screens,
                      items: controller.navItems,
                      navBarHeight: 75,
                      backgroundColor: Colors.white,
                      hideNavigationBarWhenKeyboardAppears: true,
                      navBarStyle: NavBarStyle.style4,
                      handleAndroidBackButtonPress: false,
                      onWillPop: (context) {
                        return controller.onExitApp();
                      },
                      decoration: NavBarDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withValues(alpha: 0.3),
                            spreadRadius: 10,
                            blurRadius: 30,
                          )
                        ],
                        colorBehindNavBar: Colors.transparent,
                      ),
                    ),
                  ),

                  Obx(() {
                    return AnimatedContainer(
                      height: !internetConnection.value ? 50 : 0.0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linearToEaseOut,
                      decoration: BoxDecoration(
                        color: Colors.red.shade800,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: BuildText.buildText(text: "No Internet Connection",fontFamily: FontFamily.medium,size: 15),
                        ),
                      ),
                    );
                  }),
                ],
              ),
          )
        );
      },
    );
  }
}

