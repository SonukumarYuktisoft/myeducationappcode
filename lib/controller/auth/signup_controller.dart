//
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:drive_mate/routes/route_navigation.dart';
// import 'package:drive_mate/view/onboarding/otp/verify_otp_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../core/services/api/api_controller.dart';
// import '../../core/services/api/web_constants.dart';
// import '../../core/services/secure_storage/secure_storage.dart';
// import '../../core/utils/image_picker_controller.dart';
// import '../../core/utils/print_log.dart';
// import '../../core/utils/text_field_validator.dart';
// import '../../core/utils/toast.dart';
// import '../../model/signup_response.dart';
//
// class SignupController extends GetxController with GetSingleTickerProviderStateMixin{
//
//   ApiController apiCtrl = ApiController();
//
//   RxBool isLoading = false.obs;
//   RxBool isError = false.obs;
//   RxBool isEmpty = false.obs;
//   RxBool isNetworkError = false.obs;
//   RxBool isSuccess = false.obs;
//   DateTime? lastBackPressTime;
//
//   ImagePickerController imagePickerCtrl = Get.put(ImagePickerController());
//
//   Rx<TextEditingController> fullNameController = TextEditingController().obs;
//   Rx<TextEditingController> emailController = TextEditingController().obs;
//   Rx<TextEditingController> phoneController = TextEditingController().obs;
//   Rx<CountryCode> countryCode = CountryCode(dialCode: "+1",code: "US").obs;
//
//   /// Create Password Controllers
//   Rx<TextEditingController> passwordController = TextEditingController().obs;
//   Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;
//
//   Rx<String> selectedWhoInvited = "".obs;
//
//   /// Validation Variables
//   RxBool isFullName = false.obs;
//   RxBool isEmail = false.obs;
//   RxBool isValidEmail = false.obs;
//   RxBool isPhoneNumber = false.obs;
//   RxBool isValidPhoneNumber = false.obs;
//   RxBool isUploadImage = false.obs;
//
//   /// Create Password Variables
//   RxBool isPassword = false.obs;
//   RxBool isValidPassword = false.obs;
//   RxBool isValidConfirmPassword = false.obs;
//   Rx<FocusNode> focusPassword = FocusNode().obs;
//   Rx<FocusNode> focusConfirmPassword = FocusNode().obs;
//   RxBool isAnyFieldFocused = false.obs;
//   RxBool isTermsAndPolicy = false.obs;
//
//   @override
//   void onInit() {
//     focusPassword.value.addListener(_changeListenerValue);
//     focusConfirmPassword.value.addListener(_changeListenerValue);
//     super.onInit();
//   }
//
//   /// Pick Image
//   // void getImage(source) async{
//   //   var status = await Permission.photos.status;
//   //
//   //   PrintLog.printLog("Photos Permission : $status");
//   //   if (status.isDenied || status.isRestricted) {
//   //     PrintLog.printLog("Photos Permission Requesting....");
//   //     status = await Permission.photos.request();
//   //   }
//   //   imagePickerCtrl.getImage(source:source,context: Get.context!,type: "profileImage").then((value) => update());
//   // }
//
//   /// Image Picker Bottom-sheet
//   // showImagePickerOption(){
//   //   BottomSheetCustom.showImagePickerBottomSheet(
//   //       context: Get.context!,
//   //       onValue: (value){
//   //         if(value.toString().toLowerCase() == "gallery"){
//   //           getImage("Gallery");
//   //         }else if(value.toString().toLowerCase() == "camera"){
//   //           getImage("Camera");
//   //         }
//   //       }
//   //   );
//   // }
//
//   /// Validating Fields for Rider
//   bool checkValidationRider() {
//     isFullName.value = TxtValidation.emptyTextField(fullNameController.value);
//     isEmail.value = TxtValidation.emptyTextField(emailController.value);
//     isValidEmail.value = TxtValidation.validateEmailTextField(emailController.value);
//     isPhoneNumber.value = TxtValidation.emptyTextField(phoneController.value);
//     isValidPhoneNumber.value = TxtValidation.validateMobileTextField(phoneController.value);
//     // isUploadImage.value = imagePickerCtrl.profileImage.value.path == "" || imagePickerCtrl.profileImage.value.path == "null";
//     checkPasswordValidation();
//
//     if(!isEmail.value && !isValidEmail.value && !isPhoneNumber.value && !isValidPhoneNumber.value && checkPasswordValidation()){
//       PrintLog.printLog(":::Validation Success:::");
//       return true;
//     }
//     return false;
//   }
//
//
//   /// Password Validation
//   bool checkPasswordValidation(){
//     isPassword.value = TxtValidation.emptyTextField(passwordController.value);
//     isValidPassword.value = TxtValidation.userPasswordTextField(passwordController.value);
//     isValidConfirmPassword.value = TxtValidation.confirmPasswordMatchTextField(passwordController.value,confirmPasswordController.value);
//
//     if(!isPassword.value && !isValidPassword.value && !isValidConfirmPassword.value){
//       return true;
//     }else {
//       return false;
//     }
//   }
//
//   /// On Create Account Button Click
//   Future<void> onTapCreateAccount() async{
//     FocusScope.of(Get.context!).unfocus();
//     if (checkValidationRider()) {
//       if(isTermsAndPolicy.value){
//         getSignUpApi();
//       }else{
//         ToastCustom.showSnackBar(subtitle: "Please agree our Terms&Conditions and Privacy Policy.");
//       }
//     }
//   }
//
//   /// Signup Api
//   Future<SignupResponse?> getSignUpApi() async {
//
//     String? fcmToken;
//     await AppSecureStorage.getInstance().then((value) {
//       fcmToken = value?.getString(AppSecureStorage.kFcmToken) ?? "";
//     });
//
//     changeEmptyValue(false);
//     changeLoadingValue(true);
//     changeNetworkValue(false);
//     changeErrorValue(false);
//     changeSuccessValue(false);
//
//     Map<String, dynamic> dictparm = {
//       "name" : fullNameController.value.text,
//       "email" : emailController.value.text.trim().toLowerCase(),
//       "country_code" : countryCode.value.dialCode,
//       "country_iso_code" : countryCode.value.code,
//       "mobile" : phoneController.value.text.replaceAll("-", ""),
//       "password" : passwordController.value.text.trim(),
//       "device_token": fcmToken
//     };
//
//     await apiCtrl.signupApi(url: ApiUrl.SIGNUP_API_URL, dictParameter: dictparm)
//         .then((result) async {
//       try{
//         if(result != null){
//           if (result.status != false) {
//             changeLoadingValue(false);
//             changeSuccessValue(true);
//             Get.toNamed(RouteNavigation.verifyOtpScreenRoute,arguments: VerifyOtpScreen(email: emailController.value.text, phone: "",type: "register",));
//             Get.toNamed(RouteNavigation.verifyOtpScreenRoute,arguments: VerifyOtpScreen(email: emailController.value.text, phone: "",type: "register",));
//           }else{
//             changeSuccessValue(false);
//             changeLoadingValue(false);
//             changeErrorValue(true);
//           }
//         }else{
//           changeSuccessValue(false);
//           changeLoadingValue(false);
//         }
//       }catch(error){
//         changeSuccessValue(false);
//         changeLoadingValue(false);
//         changeErrorValue(true);
//         PrintLog.printLog("Exception : $error");
//       }
//     });
//     return null;
//   }
//
//   @override
//   void onClose() {
//
//     super.onClose();
//   }
//
//
//   void changeSuccessValue(bool value) {
//     isSuccess.value = value;
//   }
//   void changeLoadingValue(bool value) {
//     isLoading.value = value;
//   }
//   void changeEmptyValue(bool value) {
//     isEmpty.value = value;
//   }
//   void changeNetworkValue(bool value) {
//     isNetworkError.value = value;
//   }
//   void changeErrorValue(bool value) {
//     isError.value = value;
//   }
//   void _changeListenerValue() {
//     isAnyFieldFocused.value = focusPassword.value.hasFocus || focusConfirmPassword.value.hasFocus;
//   }
// }
