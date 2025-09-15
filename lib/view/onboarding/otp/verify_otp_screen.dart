  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:pinput/pinput.dart';
  import '../../../controller/auth/verify_otp_controller.dart';
  import '../../../core/constants/color.dart';
  import '../../../core/constants/font_family.dart';
  import '../../../core/utils/button.dart';
  import '../../../core/utils/text.dart';

  class VerifyOtpScreen extends StatefulWidget {
    final String email;
    final String phone;
    final String type;

    const VerifyOtpScreen({super.key, required this.email, required this.phone, required this.type});

    @override
    State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
  }

  class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

    final VerifyOtpController controller = Get.put(VerifyOtpController());

    @override
    void dispose() {
      Get.delete<VerifyOtpController>();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  buildSizeBox(100.0, 0.0),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: BuildText.buildText(text: "Verify OTP",
                          size: 32,
                          fontFamily: FontFamily.bold)
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: BuildText.buildText(text: "Please verify the otp send on\n${widget.phone}",
                          size: 18,
                          color: Colors.grey.shade600,
                          fontFamily: FontFamily.medium)
                  ),
                  buildSizeBox(40.0, 0.0),
            
                  /// Otp Fields
                  otpFieldWidget(),
                  buildSizeBox(20.0, 0.0),
            
                  /// Verify Button
                  Obx(() {
                    return CustomButton(
                        isLoading: controller.isLoading.value,
                        onPressed: () => controller.onSuccess(type: widget.type,email: widget.email,mobile: widget.phone),
                        text: "Verify"
                    );
                  }),
                  buildSizeBox(20.0, 0.0),
            
                  /// Resend Code Section
                  resendOtpWidget()
                ],
              ),
            ),
          )
        ),
      );
    }

    Widget otpFieldWidget(){
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Pinput(
          controller: controller.otpController.value,
          length: 6,
          autofocus: true,
          toolbarEnabled: true,
          focusNode: controller.focusOtp.value,
          obscureText: false,
          pinAnimationType: PinAnimationType.fade,
          defaultPinTheme: defaultPinTheme.copyWith(decoration:
          defaultPinTheme.decoration!.copyWith(
            color: AppColors.textFieldBackgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: AppColors.textFieldBorderColor, width: 1),
          ),),
          separatorBuilder: (index) => const SizedBox(width: 10),
          onClipboardFound: (value) {
            debugPrint('onClipboardFound: $value');
          },
          hapticFeedbackType: HapticFeedbackType.mediumImpact,
          // onCompleted: (pin) => controller.onSuccess(email: widget.email,mobile: widget.phone,type: widget.type),
          onChanged: (value) {},
          cursor: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 2,
                height: 20,
                color: AppColors.primaryColor,
              ),
            ],
          ),
          focusedPinTheme: defaultPinTheme.copyWith(
            decoration: defaultPinTheme.decoration!.copyWith(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: AppColors.primaryColor, width: 1.5),
            ),
          ),
          submittedPinTheme: defaultPinTheme.copyWith(
            decoration: defaultPinTheme.decoration!.copyWith(
              color: AppColors.textFieldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: AppColors.textFieldBorderColor,
                  width: 1.5),
            ),
          ),
          errorPinTheme: defaultPinTheme.copyBorderWith(
            border: Border.all(color: Colors.redAccent),
          ),
        ),
      );
    }

    Widget resendOtpWidget(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            return Visibility(
              visible: controller.start.value != 0.0,
              child: Text.rich(
                  textAlign: TextAlign.start,
                  TextSpan(
                      text: "",
                      style: TextStyle(fontSize: 18,
                          color: AppColors.blackColor,
                          fontFamily: FontFamily.regular),
                      children: <TextSpan>[
                        TextSpan(
                          text: controller.formatTimer(
                              controller.start.value),
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: FontFamily.semiBold,
                            color: AppColors.blackColor,
                            decorationColor: AppColors.primaryColor,
                          ),
                        ),
                      ]
                  )
              ),
            );
          }),

          /// Resend Code
          Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                controller.isLoading2.value ?
                Center(child: CupertinoActivityIndicator(color: AppColors.whiteColor)) :
                Center(
                  child: InkWell(
                    onTap: () {
                      if(controller.start.value == 0.0) {
                        controller.onTapResendOtp(email: widget.email,mobile: widget.phone);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BuildText.buildText(
                          text: "Resend Code",
                          color: controller.start.value != 0.0 ? Colors.grey.shade600 : AppColors.primaryColor,
                          fontFamily: controller.start.value == 0.0 ? FontFamily.semiBold : FontFamily.regular,
                          size: controller.start.value == 0.0 ? 16 : 14
                      ),
                    ),
                  ),
                ),
              ],
            );
          })
        ],
      );
    }

    PinTheme defaultPinTheme = PinTheme(
      height: 56,
      width: Get.width,
      textStyle: TextStyle(
          fontSize: 28, color: AppColors.blackColor, fontFamily: FontFamily.medium),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.textFieldBorderColor, width: 1),
      ),
    );
  }