
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/onboarding/login/login_screen.dart';
import '../view/onboarding/otp/verify_otp_screen.dart';
import '../view/onboarding/splash/splash_screen.dart';

class RouteNavigation{

  static const String splashScreenRoute = '/';
  static const String welcomeScreenRoute = 'welcome_screen';
  static const String loginScreenRoute = 'login_screen';
  static const String signupScreenRoute = 'signup_screen';
  static const String verifyOtpScreenRoute = 'verify_otp_screen';
  static const String forgotPasswordScreenRoute = 'forgot_password_screen';
  static const String createNewPasswordScreenRoute = 'create_new_password_screen';
  static const String dashboardScreenRoute = 'dashboard_screen';
  static const String chatDetailScreenRoute = 'chat_detail_screen';
  static const String scheduleDriveScreenRoute = 'schedule_drive_screen';
  static const String driveListScreenRoute = 'drive_list_screen';
  static const String startDriveScreenRoute = 'start_drive_screen';
  static const String findDriveMatesScreenRoute = 'find_drive_mates_screen';
  static const String endDriveScreenRoute = 'end_drive_screen';
  static const String profileScreenRoute = 'profile_screen';
  static const String settingsScreenRoute = 'settings_screen';


  static GetPageRoute<dynamic>? generateRoute(RouteSettings settings){
    switch(settings.name) {

      case splashScreenRoute:
        return GetPageRoute(page: () => SplashScreen(),transition: Platform.isAndroid ? Transition.rightToLeftWithFade : Transition.native,curve: Platform.isAndroid ? Curves.fastOutSlowIn : null,routeName: splashScreenRoute);
      //
      case loginScreenRoute:
        return GetPageRoute(page: () => LoginScreen(),transition: Platform.isAndroid ? Transition.rightToLeftWithFade : Transition.native,curve: Platform.isAndroid ? Curves.fastOutSlowIn : null,routeName: splashScreenRoute);
      //
      // case signupScreenRoute:
      //   return GetPageRoute(page: () => SignupScreen(),transition: Platform.isAndroid ? Transition.rightToLeftWithFade : Transition.native,curve: Platform.isAndroid ? Curves.fastOutSlowIn : null,routeName: splashScreenRoute);
      //
      case verifyOtpScreenRoute:
        final argument  = settings.arguments as VerifyOtpScreen;
        return GetPageRoute(page: () => VerifyOtpScreen( email: argument.email,phone: argument.phone,type: argument.type,),transition: Platform.isAndroid ? Transition.rightToLeftWithFade : Transition.native,curve: Platform.isAndroid ? Curves.fastOutSlowIn : null,routeName: splashScreenRoute);

      default:
        return GetPageRoute(page: () => SplashScreen(),transition: Platform.isAndroid ? Transition.rightToLeftWithFade : Transition.native,curve: Platform.isAndroid ? Curves.fastOutSlowIn : null,routeName: splashScreenRoute);
    }
  }

}
