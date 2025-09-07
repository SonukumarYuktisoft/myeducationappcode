// import 'package:drive_mate/core/utils/text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controller/auth/forgot_password_controller.dart';
// import '../../../core/utils/button.dart';
// import '../../../core/utils/text.dart';
// import '../widget/onboarding_widget.dart';
//
// class ForgotPasswordScreen extends StatelessWidget {
//   ForgotPasswordScreen({super.key});
//
//   final ForgotPasswordController controller = Get.put(
//       ForgotPasswordController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: OnboardingWidget(
//             showBackBtn: true,
//             showUserIcon: false,
//             title: "Forgot Password",
//             subTitle: "Enter your email address to recover password",
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Obx(() {
//                 return TextFieldCustom(
//                   hintText: "Enter your email",
//                   controller: controller.emailController.value,
//                   keyboardType: TextInputType.emailAddress,
//                   textCapitalization: TextCapitalization.none,
//                   errorText: controller.isEmail.value ? "Enter email" : "",
//                 );
//               }),
//
//               buildSizeBox(20.0, 0.0),
//
//               Obx(() {
//                 return CustomButton(
//                     isLoading: controller.isLoading.value,
//                     onPressed: () => controller.onTapSendCode(),
//                     text: "Send Verification Code"
//                 );
//               }),
//             ]
//         ),
//       ),
//     );
//   }
// }