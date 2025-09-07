import 'package:education/view/onboarding/otp/verify_otp_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/constants/color.dart';
import '../../../core/constants/font_family.dart';
import '../../../core/utils/appbar_custom.dart';
import '../../../core/utils/button.dart';
import '../../../core/utils/custom_snackbar.dart';
import '../../../core/utils/text.dart';
import '../../../core/utils/text_field.dart';
import '../../../routes/route_navigation.dart';
import '../../../controller/auth/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, dynamic) async {
        if (didPop) return;

        final now = DateTime.now();
        if (controller.lastBackPressTime == null ||
            now.difference(controller.lastBackPressTime!) >
                const Duration(seconds: 2)) {
          controller.lastBackPressTime = now;
          FadeSnackBar.show(context, 'Press back again to exit');
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildSizeBox(100.0, 0.0),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: BuildText.buildText(text: "Welcome To,\nLogin",
                          size: 32,
                          fontFamily: FontFamily.bold)
                  ),
                  buildSizeBox(40.0, 0.0),

                  formFieldSection(),
                  buildSizeBox(20.0, 0.0),

                  CustomButton(
                    onPressed: () {
                      Get.toNamed(RouteNavigation.verifyOtpScreenRoute,
                          arguments: VerifyOtpScreen(email: '',
                              phone: controller.phoneController.value.text,
                              type: "phone"));
                    },
                    text: "Login",
                  ),
                  buildSizeBox(20.0, 0.0),
                  bottomWidget(),
                ],
              ),
            ),
          )
      ),
    );
  }

  Widget loginTypeWidget() {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: AppColors.clr222222,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TabBar(
        controller: controller.tabController,
        physics: const NeverScrollableScrollPhysics(),
        indicator: BoxDecoration(
          color: AppColors.blackColor,
          borderRadius: BorderRadius.circular(30),
        ),
        dividerHeight: 0,
        indicatorSize: TabBarIndicatorSize.tab,
        automaticIndicatorColorAdjustment: true,
        labelColor: AppColors.whiteColor,
        unselectedLabelColor: AppColors.whiteColor,
        labelStyle: TextStyle(
          fontSize: 14,
          fontFamily: FontFamily.semiBold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontFamily: FontFamily.semiBold,
        ),
        onTap: (value) {
          controller.onChangeTabs(value);
        },
        labelPadding: const EdgeInsets.symmetric(vertical: 10),
        tabs: const [
          Text("Email"),
          Text("Phone"),
        ],
      ),
    );
  }

  Widget formFieldSection() {
    return AnimatedSize(
      duration: Duration(milliseconds: 600),
      curve: Curves.linearToEaseOut,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // /// Phone Number
          // if (controller.tabController.index == 1)
          TextFieldForPhone(
            focusNode: controller.focusNodePhone,
            controller: controller.phoneController.value,
            hint: "Enter your phone number",
            countryCode: "US",
            initialCountryCode: "US",
            phoneCode: "+1",
            errortext: controller.isPhoneNumber
                ? "Enter Phone Number"
                : controller.isValidPhoneNumber
                ? "Enter Valid Phone Number"
                : "",
            onChangedCode: (value) {
              controller.countryCode.value =
                  value.dialCode ?? "";
            },
          ),

          /// Email
          // if (controller.tabController.index == 0) ...[
          //   TextFieldCustom(
          //     focusNode: controller.focusEmail,
          //     controller: controller.emailController,
          //     hintText: "Enter your email",
          //     errorText:
          //     controller.isValidateEmail
          //         ? "Enter Email"
          //         : "",
          //     keyboardType: TextInputType.emailAddress,
          //     textCapitalization: TextCapitalization.none,
          //   ),
          //   buildSizeBox(15.0, 0.0),
          //
          //   /// Password
          //   TextFieldCustom(
          //     focusNode: controller.focusPassword,
          //     controller: controller.passwordController,
          //     hintText: "Password",
          //     errorText: controller.isValidatePassword
          //         ? "Enter Password"
          //         : "",
          //     keyboardType: TextInputType.visiblePassword,
          //     isPassword: true,
          //   ),
          // ],

          /// Forgot Password
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    Get.toNamed(
                        RouteNavigation.forgotPasswordScreenRoute);
                  },
                  child: BuildText.buildText(
                      text: "Forgot Password?",
                      size: 14,
                      fontFamily: FontFamily.medium)
              )
          ),
        ],
      ),
    );
  }

  Widget bottomWidget() {
    return Positioned(
      bottom: 25,
      left: 0,
      right: 0,
      child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
              text: "Don't have an account? ",
              style: TextStyle(fontSize: 15,
                  color: AppColors.blackColor,
                  fontFamily: FontFamily.semiBold),
              children: <TextSpan>[
                TextSpan(
                    text: "Sign Up",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: FontFamily.bold,
                      color: AppColors.blackColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.offAndToNamed(RouteNavigation.signupScreenRoute);
                      }
                ),
              ]
          )
      ),
    );
  }
}
