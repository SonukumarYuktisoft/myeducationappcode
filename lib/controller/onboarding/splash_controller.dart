

import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/api/api_controller.dart';
import '../../core/services/secure_storage/secure_storage.dart';
import '../../core/utils/print_log.dart';
import '../../routes/route_navigation.dart';
import '../../view/dashboard/dashboard_screen.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin{

  ApiController apiCtrl = ApiController();

  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxBool isEmpty = false.obs;
  RxBool isNetworkError = false.obs;
  RxBool isSuccess = false.obs;

  AnimationController? animationController;
  late Animation<double> rotation;
  late final Animation<double> fade;
  late final Animation<double> fadeText;

  RxString isLogin = "".obs;
  RxString fcmToken = "".obs;

  @override
  void onInit() {
    initCalling();
    super.onInit();
  }

  initCalling()async{
    animationController = AnimationController(
        vsync: this,duration: Duration(milliseconds: 1200)
    );

    rotation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.3), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -0.3, end: 0.3), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.3, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeInOut,
    ));
    fade = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: animationController!, curve: Curves.easeIn),
    );
    fadeText = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(parent: animationController!, curve: Curves.easeIn),
    );
    animationController?.forward();

    animationController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkLogin();
      }
    });
  }

  Future<void> checkLogin()async{

    // await permissionCtrl.requestLocationPermissions();

    await SharedPreferences.getInstance().then((value) {
      isLogin.value = value.getString(AppSecureStorage.kIsLogin) ?? "";
      fcmToken.value = value.getString(AppSecureStorage.kFcmToken) ?? "";
    });

    if(fcmToken.value == ""){
      // fcmToken.value = await FirebaseMessagingCustom.getToken() ?? "";
      await AppSecureStorage.addStringValueToSharedPref(variableName: AppSecureStorage.kFcmToken, variableValue: fcmToken.value);
      PrintLog.printLog(('FCM TOKEN is : ${fcmToken.value}'));
    }
    runSplash();
  }

  void runSplash() {
    PrintLog.printLog("isLogin : ${isLogin.value}");
    Future.delayed(const Duration(milliseconds: 200),(){
      if(isLogin.value == "true"){
        // Get.toNamed(RouteNavigation.dashboardScreenRoute,arguments: DashboardScreen(index: 1));
      }else{
        Get.offAndToNamed(RouteNavigation.loginScreenRoute);
      }
    });
    update();
  }

  void changeSuccessValue(bool value) {
    isSuccess.value = value;
  }
  void changeLoadingValue(bool value) {
    isLoading.value = value;
  }
  void changeEmptyValue(bool value) {
    isEmpty.value = value;
  }
  void changeNetworkValue(bool value) {
    isNetworkError.value = value;
  }
  void changeErrorValue(bool value) {
    isError.value = value;
  }
}