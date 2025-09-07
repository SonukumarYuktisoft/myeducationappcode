import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/api/api_controller.dart';
import '../../core/utils/text_field_validator.dart';

class ForgotPasswordController extends GetxController{

  ApiController apiCtrl = ApiController();
  // ForgotPasswordData? forgotPasswordData;

  /// Api variables
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxBool isEmpty = false.obs;
  RxBool isNetworkError = false.obs;
  RxBool isSuccess = false.obs;

  Rx<TextEditingController> emailController = TextEditingController().obs;

  RxBool isEmail = false.obs;
  RxBool isNewPassword = false.obs;
  RxBool isValidNewPassword = false.obs;
  RxBool isConfirmPassword = false.obs;
  RxBool isValidConfirmPassword = false.obs;

  /// Create New Password
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;

  /// On Tap Send Verification Code
  onTapSendCode(){
    isEmail.value = TxtValidation.emptyTextField(emailController.value);
    if(!isEmail.value) {
      // forgotPasswordApi();
    }
  }

  /// On Tap Update Password
  onTapUpdatePassword()async{
    isNewPassword.value = TxtValidation.emptyTextField(passwordController.value);
    isValidNewPassword.value = TxtValidation.userPasswordTextField(passwordController.value);
    isConfirmPassword.value = TxtValidation.emptyTextField(confirmPasswordController.value);
    isValidConfirmPassword.value = TxtValidation.confirmPasswordMatchTextField(passwordController.value,confirmPasswordController.value);
    if(!isNewPassword.value && !isConfirmPassword.value && !isValidConfirmPassword.value){
      // await changePasswordApi();
    }

  }

  // Future<ForgotPasswordResponse?> forgotPasswordApi() async {
  //
  //   changeEmptyValue(false);
  //   changeLoadingValue(true);
  //   changeNetworkValue(false);
  //   changeErrorValue(false);
  //   changeSuccessValue(false);
  //
  //   Map<String, dynamic> dictparm = {
  //     "email" : emailController.value.text.trim().toLowerCase(),
  //   };
  //
  //   await apiCtrl.forgotPasswordApi(url: ApiUrl.FORGOT_PASSWORD_API_URL, dictParameter: dictparm)
  //       .then((result) async {
  //     try{
  //       if(result != null){
  //         if (result.status != false) {
  //           changeLoadingValue(false);
  //           changeSuccessValue(true);
  //           Get.toNamed(
  //             RouteNavigation.verifyOtpScreenRoute,
  //             arguments: VerifyOtpScreen(email: emailController.value.text,phone: "",type: 'forgot_password',)
  //           );
  //           ToastCustom.showSnackBar(subtitle: result.message,isSuccess: true);
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
  //
  // /// Change Password Api
  // Future<ResetPasswordResponse?> changePasswordApi() async {
  //
  //   changeEmptyValue(false);
  //   changeLoadingValue(true);
  //   changeNetworkValue(false);
  //   changeErrorValue(false);
  //   changeSuccessValue(false);
  //
  //   Map<String, dynamic> dictparm = {
  //     "email" : emailController.value.text.trim(),
  //     "password" : passwordController.value.text.trim(),
  //   };
  //
  //   await apiCtrl.resetPasswordApi(url: ApiUrl.RESET_PASSWORD_API_URL, dictParameter: dictparm)
  //       .then((result) async {
  //     try{
  //       if(result != null){
  //         if (result.status != false) {
  //           changeLoadingValue(false);
  //           changeSuccessValue(true);
  //           Get.offAllNamed(RouteNavigation.loginScreenRoute);
  //           ToastCustom.showSnackBar(subtitle: result.message,isSuccess: true);
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