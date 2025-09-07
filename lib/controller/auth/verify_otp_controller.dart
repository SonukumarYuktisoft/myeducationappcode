import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/api/api_controller.dart';
import '../../core/services/secure_storage/secure_storage.dart';
import '../../core/utils/toast.dart';
import '../../main.dart';

class VerifyOtpController extends GetxController{

  ApiController apiCtrl = ApiController();

  /// Api variables
  RxBool isLoading = false.obs;
  RxBool isLoading2 = false.obs;
  RxBool isError = false.obs;
  RxBool isEmpty = false.obs;
  RxBool isNetworkError = false.obs;
  RxBool isSuccess = false.obs;

  /// Local Variables
  Rx<TextEditingController> otpController = TextEditingController().obs;
  Rx<FocusNode> focusOtp = FocusNode().obs;

  /// Timer for resend otp
  Timer? timer;
  RxDouble start = 0.0.obs;
  RxBool isTimerStart = false.obs;

  @override
  void onInit() {
    isTimerStart.value = true;
    start.value = 30.0;
    startTimer();
    super.onInit();
  }

  Future<void> onSuccess({required String email,required String mobile,required String type})async{
    if(otpController.value.text.length >=6) {
      FocusScope.of(Get.context!).unfocus();
      // getVerifyOtpApi(email: email,mobile: mobile,type: type);
    }else{
      ToastCustom.showSnackBar(subtitle: "Please enter valid otp",isSuccess: false);
    }
  }

  Future<void> onTapResendOtp({required String mobile, required String email}) async {
    // await resendOtpApi(mobile: mobile, email: email);
    isTimerStart.value = true;
    start.value = 30.0;
    startTimer();
    clearTextField();
  }

  /// Verify Otp Api
  // Future<VerifyOtpResponse?> getVerifyOtpApi({required String email,required String mobile,required String type}) async {
  //
  //   String fcmToken = AppSecureStorage.getStringFromSharedPref(variableName: AppSecureStorage.kFcmToken) ?? "";
  //
  //   changeEmptyValue(false);
  //   changeLoadingValue(true);
  //   changeNetworkValue(false);
  //   changeErrorValue(false);
  //   changeSuccessValue(false);
  //
  //   Map<String, dynamic> dictparm = {
  //     "email" : email.trim().toLowerCase(),
  //     "mobile": mobile.split(" ").last.replaceAll("-", ""),
  //     "country_code": mobile.split(" ").first,
  //     "otp": otpController.value.text,
  //     'type': mobile != "" ? 'mobile' : 'email',
  //     "device_token": fcmToken
  //   };
  //
  //   await apiCtrl.verifyOtpApi(url: type == 'register' ? ApiUrl.SIGN_VERIFY_OTP_API_URL : ApiUrl.VERIFY_OTP_API_URL, dictParameter: dictparm)
  //       .then((result) async {
  //     try{
  //       if(result != null){
  //         if (result.status != false) {
  //           await saveUserData(data: result);
  //           changeLoadingValue(false);
  //           changeSuccessValue(true);
  //           if(type == "forgot_password" && email != ""){
  //             Get.toNamed(RouteNavigation.createNewPasswordScreenRoute,arguments: CreateNewPasswordScreen(email: email));
  //           }else if(type == "register"){
  //             await AppSecureStorage.addStringValueToSharedPref(variableName: AppSecureStorage.kIsLogin, variableValue: 'true');
  //             Get.toNamed(RouteNavigation.profileScreenRoute,arguments: ProfileScreen(isFromRegister: true));
  //           }else if(type == "login"){
  //             await AppSecureStorage.addStringValueToSharedPref(variableName: AppSecureStorage.kIsLogin, variableValue: 'true');
  //             Get.toNamed(RouteNavigation.dashboardScreenRoute,arguments: DashboardScreen(index: 1));
  //           }
  //           clearTextField();
  //         }else{
  //           changeSuccessValue(false);
  //           changeLoadingValue(false);
  //           changeErrorValue(true);
  //         }
  //       }else{
  //         changeSuccessValue(false);
  //         changeLoadingValue(false);
  //       }
  //     }catch(error){
  //       changeSuccessValue(false);
  //       changeLoadingValue(false);
  //       changeErrorValue(true);
  //       PrintLog.printLog("Exception : $error");
  //     }
  //   });
  //   update();
  //   return null;
  // }

  // Future<void> saveUserData({VerifyOtpResponse? data}) async {
  //   await AppSecureStorage.addStringValueToSharedPref(variableName: AppSecureStorage.kUserId, variableValue: data?.data?.user?.id ?? "");
  //   await AppSecureStorage.addStringValueToSharedPref(variableName: AppSecureStorage.kFirstName, variableValue: data?.data?.user?.name ?? "");
  //   await AppSecureStorage.addStringValueToSharedPref(variableName: AppSecureStorage.kUserPhone, variableValue: data?.data?.user?.mobile ?? "");
  //   await AppSecureStorage.addStringValueToSharedPref(variableName: AppSecureStorage.kUserEmail, variableValue: data?.data?.user?.email ?? "");
  //   await AppSecureStorage.addStringValueToSharedPref(variableName: AppSecureStorage.kAuthToken, variableValue: data?.data?.usertoken ?? "");
  //   await AppSecureStorage.addStringValueToSharedPref(variableName: AppSecureStorage.kUserProfileImage, variableValue: data?.data?.user?.profilePhotoUrl ?? "");
  //
  //   accessToken = data?.data?.usertoken ?? "";
  // }

  /// Resend Otp Api
  // Future<ResendOtpResponse?> resendOtpApi({required String mobile, required String email}) async {
  //
  //   changeEmptyValue(false);
  //   changeLoadingValue2(true);
  //   changeNetworkValue(false);
  //   changeErrorValue(false);
  //   changeSuccessValue(false);
  //
  //   Map<String, dynamic> dictparm = {
  //     "email" : email,
  //     "mobile" : mobile.split(" ").last.replaceAll("-", ""),
  //     "country_code": mobile.split(" ").first,
  //     "country_iso_code": "",
  //     "type": mobile != "" ? 'mobile' : 'email',
  //   };
  //
  //   await apiCtrl.resendOtpApi(url: ApiUrl.RESEND_OTP_API_URL, dictParameter: dictparm)
  //       .then((result) async {
  //     try{
  //       if(result != null){
  //         if (result.status != false) {
  //           ToastCustom.showSnackBar(subtitle: result.message ?? "",isSuccess: true);
  //           changeLoadingValue2(false);
  //           changeSuccessValue(true);
  //           clearTextField();
  //         }else{
  //           changeSuccessValue(false);
  //           changeLoadingValue2(false);
  //           changeErrorValue(true);
  //         }
  //       }else{
  //         changeSuccessValue(false);
  //         changeLoadingValue2(false);
  //       }
  //     }catch(error){
  //       changeSuccessValue(false);
  //       changeLoadingValue2(false);
  //       changeErrorValue(true);
  //       PrintLog.printLog("Exception : $error");
  //     }
  //   });
  //   update();
  //   return null;
  // }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (start.value == 0.0) {
          isTimerStart.value = false;
          timer.cancel();
          update();
        } else {
          start.value--;
          update();
        }
      },
    );
  }

  clearTextField() async {
    otpController.value.clear();
    focusOtp.value.requestFocus();
    update();
  }

  String formatTimer(double seconds) {
    int minutes = (seconds ~/ 60).toInt();
    int remainingSeconds = (seconds % 60).toInt();
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }


  void changeSuccessValue(bool value) {
    isSuccess.value = value;
  }
  void changeLoadingValue(bool value) {
    isLoading.value = value;
  }
  void changeLoadingValue2(bool value) {
    isLoading2.value = value;
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