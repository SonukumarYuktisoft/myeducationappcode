// import 'package:drive_mate/core/utils/text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controller/auth/forgot_password_controller.dart';
// import '../../../core/utils/button.dart';
// import '../../../core/utils/text.dart';
// import '../widget/onboarding_widget.dart';
//
// class CreateNewPasswordScreen extends StatelessWidget {
//   final String email;
//   CreateNewPasswordScreen({super.key, required this.email});
//
//   final ForgotPasswordController controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: OnboardingWidget(
//             showBackBtn: true,
//             showUserIcon: false,
//             title: "Set new password",
//             subTitle: "Set new password for your account",
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               // Enter New Password
//               Obx((){
//                 return TextFieldCustom(
//                   controller: controller.passwordController.value,
//                   hintText: "Password",
//                   isPassword: true,
//                   errorText: controller.isNewPassword.value ? "Enter password" : controller.isValidNewPassword.value ? "Enter min 5 digit password" : null,
//                 );
//               }),
//               buildSizeBox(20.0, 0.0),
//
//               /// Enter Confirm Password
//               Obx((){
//                 return TextFieldCustom(
//                   controller: controller.confirmPasswordController.value,
//                   hintText: "Confirm Password",
//                   isPassword: true,
//                   errorText: controller.isConfirmPassword.value ? "Enter confirm password" : controller.isValidConfirmPassword.value ? "New password and confirm password must be same" : null,
//                 );
//               }),
//
//               buildSizeBox(20.0, 0.0),
//
//               Obx(() {
//                 return CustomButton(
//                     isLoading: controller.isLoading.value,
//                     onPressed: ()=> controller.onTapUpdatePassword(),
//                     text: "Update"
//                 );
//               }),
//             ]
//         ),
//       ),
//     );
//   }
// }