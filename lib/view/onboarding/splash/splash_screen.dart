import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controller/onboarding/splash_controller.dart';
import '../../../core/constants/color.dart';
import '../../../core/constants/font_family.dart';
import '../../../core/constants/string_define.dart';
import '../../../core/utils/base_image.dart';
import '../../../core/utils/text.dart';

class SplashScreen extends StatelessWidget {
 SplashScreen({super.key});

 final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [

            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: AnimatedSize(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.linearToEaseOut,
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      // if(controller.animationController != null)
                      // AnimatedBuilder(
                      //   animation: controller.animationController!,
                      //   builder: (_, child) {
                      //     return FadeTransition(
                      //       opacity: controller.fade,
                      //       child: Transform.rotate(
                      //         angle: controller.rotation.value, // full circle
                      //         child: child,
                      //       ),
                      //     );
                      //   },
                      //   child: BaseImage.image(
                      //     path: AppString.logo,
                      //     width: 100,
                      //     height: 100,
                      //   ),
                      // ),

                      if(controller.animationController != null)
                      FadeTransition(
                        opacity: controller.fadeText,
                        child: BuildText.buildText(text: "Education App",size: 45,fontFamily: FontFamily.bold,color: Color(0xff44755B))
                      )
                      // BaseImage.image(path: AppString.splashLogo),
                    ],
                  ),
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}