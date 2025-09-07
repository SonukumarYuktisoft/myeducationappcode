// import 'package:drive_mate/routes/route_navigation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import '../../../controller/auth/signup_controller.dart';
// import '../../../core/constants/color.dart';
// import '../../../core/constants/font_family.dart';
// import '../../../core/utils/button.dart';
// import '../../../core/utils/custom_snackbar.dart';
// import '../../../core/utils/text.dart';
// import '../../../core/utils/text_field.dart';
// import '../widget/onboarding_widget.dart';
//
// class SignupScreen extends StatelessWidget {
//   SignupScreen({super.key});
//
//   final SignupController controller = Get.put(SignupController());
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (didPop, dynamic) async {
//         if (didPop) return;
//
//         final now = DateTime.now();
//         if (controller.lastBackPressTime == null ||
//             now.difference(controller.lastBackPressTime!) > const Duration(seconds: 2)) {
//           controller.lastBackPressTime = now;
//           FadeSnackBar.show(context, 'Press back again to exit');
//         } else {
//           SystemNavigator.pop();
//         }
//
//       },
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Stack(
//             children: [
//               OnboardingWidget(
//                 gapUnderLogo: 30.0,
//                 showBackBtn: false,
//                 showUserIcon: true,
//                 title: "Login Account  ",
//                 subTitle: "Hello, welcome back to our account !",
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   /// Form Fields
//                   formFieldWidgets(),
//
//                   /// Agree Terms of use
//                   agreeTermPolicyWidget(),
//
//                   /// Register Button
//                   Obx(() {
//                     return CustomButton(
//                         isLoading: controller.isLoading.value,
//                         onPressed: () => controller.onTapCreateAccount(),
//                         text: "Register"
//                     );
//                   }),
//                 ]
//               ),
//
//               /// Bottom Section
//               bottomWidget()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget formFieldWidgets(){
//     return Obx(() {
//       return Column(
//         children: [
//           /// Full Name
//           TextFieldCustom(
//             controller: controller.fullNameController.value,
//             hintText: "Full Name",
//             keyboardType: TextInputType.text,
//             textCapitalization: TextCapitalization.words,
//             errorText: controller.isFullName.value
//                 ? "Enter your full name"
//                 : "",
//           ),
//           buildSizeBox(15.0, 0.0),
//
//           /// Email
//           TextFieldCustom(
//             controller: controller.emailController.value,
//             hintText: "Email",
//             keyboardType: TextInputType.emailAddress,
//             textCapitalization: TextCapitalization.none,
//             errorText: controller.isEmail.value
//                 ? "Enter your email"
//                 : "",
//           ),
//           buildSizeBox(15.0, 0.0),
//
//           /// Phone
//           TextFieldForPhone(
//             controller: controller.phoneController.value,
//             hint: "Enter your phone number",
//             countryCode: "US",
//             initialCountryCode: "US",
//             phoneCode: "+1",
//             errortext: controller.isPhoneNumber.value
//                 ? "Enter phone number"
//                 : "",
//           ),
//           buildSizeBox(15.0, 0.0),
//
//           /// Password
//           TextFieldCustom(
//             controller: controller.passwordController.value,
//             hintText: "Password",
//             errorText: controller.isPassword.value ? "Enter Password" : controller.isValidPassword.value ? "Please enter min 5 digit password" : "",
//             keyboardType: TextInputType.visiblePassword,
//           ),
//           buildSizeBox(15.0, 0.0),
//
//           /// Confirm Password
//           TextFieldCustom(
//             controller: controller.confirmPasswordController.value,
//             hintText: "Confirm Password",
//             errorText: controller.isValidConfirmPassword.value
//                 ? "Password and confirm password must be same"
//                 : "",
//             textInputAction: TextInputAction.done,
//             keyboardType: TextInputType.visiblePassword,
//           ),
//           buildSizeBox(15.0, 0.0),
//         ],
//       );
//     });
//   }
//
//   Widget agreeTermPolicyWidget(){
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Obx(() {
//               return Checkbox(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(4.0)),
//                 fillColor: WidgetStateProperty.all(controller
//                     .isTermsAndPolicy.value
//                     ? AppColors.primaryColor
//                     : AppColors.whiteColor),
//                 side: BorderSide(color: !controller.isTermsAndPolicy
//                     .value ? Colors.grey.shade900 : Colors
//                     .transparent, width: 0.0),
//                 checkColor: AppColors.blackColor,
//                 visualDensity: const VisualDensity(
//                     vertical: -4, horizontal: -4),
//                 value: controller.isTermsAndPolicy.value,
//                 materialTapTargetSize: MaterialTapTargetSize
//                     .shrinkWrap,
//                 onChanged: (bool? val) {
//                   controller.isTermsAndPolicy.value = val ?? false;
//                 },
//               );
//             }),
//             buildSizeBox(0.0, 6.0),
//             Expanded(
//               child: Text.rich(
//                   textAlign: TextAlign.start,
//                   TextSpan(
//                       text: "I agree to ",
//                       style: TextStyle(fontSize: 13,
//                         color: AppColors.whiteColor,
//                         fontFamily: FontFamily.regular,),
//                       children: <TextSpan>[
//                         TextSpan(
//                             text: "Terms of Use",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontFamily: FontFamily.semiBold,
//                               color: AppColors.primaryColor,
//                               decorationColor: AppColors.primaryColor,
//                             ),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 // LaunchUrlCustom.redirectToBrowser(ApiUrl.TERMS_AND_CONDITIONS_URL);
//                               }
//                         ),
//                         TextSpan(
//                           text: " and ",
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontFamily: FontFamily.regular,
//                             color: AppColors.whiteColor,
//                           ),
//                         ),
//                         TextSpan(
//                             text: "Privacy Policy",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontFamily: FontFamily.semiBold,
//                               color: AppColors.primaryColor,
//                               decorationColor: AppColors.primaryColor,
//                             ),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 // LaunchUrlCustom.redirectToBrowser(ApiUrl.PRIVACY_POLICY_URL);
//                               }
//                         ),
//                       ]
//                   )
//               ),
//             ),
//           ],
//         ),
//         buildSizeBox(30.0, 0.0),
//       ],
//     );
//   }
//
//   Widget bottomWidget(){
//     return Positioned(
//       bottom: 25,
//       left: 0,
//       right: 0,
//       child: Text.rich(
//           textAlign: TextAlign.center,
//           TextSpan(
//               text: "Already have an account? ",
//               style: TextStyle(fontSize: 14,
//                   color: AppColors.whiteColor,
//                   fontFamily: FontFamily.semiBold),
//               children: <TextSpan>[
//                 TextSpan(
//                     text: "Sign In",
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontFamily: FontFamily.bold,
//                       color: AppColors.whiteColor,
//                     ),
//                     recognizer: TapGestureRecognizer()
//                       ..onTap = () {
//                         Get.offAndToNamed(RouteNavigation.loginScreenRoute);
//                         // Get.toNamed(RouteNavigation.loginScreenRoute);
//                       }
//                 ),
//               ])
//       ),
//     );
//   }
// }