import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/api/api_controller.dart';
import '../../core/services/api/web_constants.dart';
import '../../core/services/secure_storage/secure_storage.dart';
import '../../core/utils/print_log.dart';
import '../../core/utils/text_field_validator.dart';
import '../../core/utils/toast.dart';
import '../../main.dart';

class LoginController extends GetxController with GetSingleTickerProviderStateMixin{

  ApiController apiCtrl = ApiController();

  /// Api variables
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxBool isEmpty = false.obs;
  RxBool isNetworkError = false.obs;
  RxBool isSuccess = false.obs;
  DateTime? lastBackPressTime;

  late TabController tabController;

  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  RxString countryCode = "+1".obs;

  bool isValidateEmail = false;
  bool isValidatePassword = false;
  bool isPhoneNumber = false;
  bool isValidPhoneNumber = false;

  FocusNode focusNodePhone = FocusNode();
  FocusNode focusEmail = FocusNode();
  FocusNode focusPassword = FocusNode();

  @override
  void onInit(){
    tabController = TabController(length: 2, vsync: this);
    focusNodePhone.addListener(update);
    focusEmail.addListener(update);
    focusPassword.addListener(update);
    super.onInit();
  }

  @override
  void onClose() {
   disposeTxtCtrl();
    super.onClose();
  }

  Future<void> disposeTxtCtrl() async {
    emailController.value.clear();
    passwordController.value.clear();
  }

  bool checkValidation(){
    if(tabController.index == 1){
      isPhoneNumber = TxtValidation.emptyTextField(phoneController.value);
      isValidPhoneNumber = TxtValidation.validateMobileTextField(phoneController.value);
      if(!isPhoneNumber && !isValidPhoneNumber) return true;
      update();
      return false;
    }else{
      isValidateEmail = TxtValidation.emptyTextField(emailController.value);
      isValidatePassword = TxtValidation.emptyTextField(passwordController.value);
      if(!isValidateEmail && !isValidatePassword) return true;
      update();
      return false;
    }
  }

  onChangeTabs(value){
    tabController.index = value;
    PrintLog.printLog("Tab Index : ${tabController.index}");
    update();
  }

  Future<void> onTapSignIn(context)async{
    FocusScope.of(context).unfocus();
    if(checkValidation()){
       // getLoginApi();
    }
  }

  /// Login Api
  // Future<LoginResponse?> getLoginApi() async {
  //
  //   String? fcmToken;
  //   await AppSecureStorage.getInstance().then((value) {
  //     fcmToken = value?.getString(AppSecureStorage.kFcmToken) ?? "";
  //   });
  //
  //   changeEmptyValue(false);
  //   changeLoadingValue(true);
  //   changeNetworkValue(false);
  //   changeErrorValue(false);
  //   changeSuccessValue(false);
  //
  //    Map<String, dynamic> dictparm = {
  //     "email": emailController.value.text.trim().toLowerCase(),
  //     "mobile": phoneController.value.text.replaceAll("-", ""),
  //     "password": passwordController.value.text,
  //     "login_type": tabController.index == 0 ? "email" : "mobile",
  //     "country_code": countryCode.value,
  //     "device_token": fcmToken
  //   };
  //
  //   await apiCtrl.loginApi(url: ApiUrl.LOGIN_API_URL, dictParameter: dictparm)
  //       .then((result) async {
  //     try{
  //       if(result != null){
  //         if (result.status != false) {
  //           await saveUserData(data: result.data);
  //           changeLoadingValue(false);
  //           changeSuccessValue(true);
  //           if(tabController.index == 0){
  //             Get.toNamed(RouteNavigation.dashboardScreenRoute,arguments: DashboardScreen(index: 1));
  //             ToastCustom.showSnackBar(subtitle: result.message ?? "",isSuccess: true);
  //             await AppSecureStorage.addStringValueToSharedPref(variableName: AppSecureStorage.kIsLogin, variableValue: 'true');
  //           }else{
  //             Get.toNamed(RouteNavigation.verifyOtpScreenRoute,arguments: VerifyOtpScreen(email: "", phone: "${countryCode.value} ${phoneController.text}" , type: "login"));
  //             ToastCustom.showSnackBar(subtitle: result.message ?? "",isSuccess: true);
  //           }
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

  // Future<void> saveUserData({LoginData? data}) async {
  //   await AppSecureStorage.addStringValueToSharedPref(variableName: AppSecureStorage.kUserId, variableValue: data?.user?.id ?? "");
  //   await AppSecureStorage.addStringValueToSharedPref(variableName: AppSecureStorage.kFirstName, variableValue: data?.user?.name ?? "");
  //   await AppSecureStorage.addStringValueToSharedPref(variableName: AppSecureStorage.kUserPhone, variableValue: data?.user?.mobile ?? "");
  //   await AppSecureStorage.addStringValueToSharedPref(variableName: AppSecureStorage.kUserEmail, variableValue: data?.user?.email ?? "");
  //   await AppSecureStorage.addStringValueToSharedPref(variableName: AppSecureStorage.kAuthToken, variableValue: data?.usertoken ?? "");
  //   await AppSecureStorage.addStringValueToSharedPref(variableName: AppSecureStorage.kUserProfileImage, variableValue: data?.user?.profilePhotoUrl ?? "");
  //
  //   accessToken = data?.usertoken ?? "";
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