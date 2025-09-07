import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/color.dart';
import '../../constants/font_family.dart';
import '../../constants/string_define.dart';
import '../text.dart';
import 'loading_widget_controller.dart';

class LoadingWidget extends StatelessWidget {
  final bool isDataLoad;

  const LoadingWidget({super.key, required this.isDataLoad});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: isDataLoad ? Colors.transparent : Colors.black.withValues(
          alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            isDataLoad ?
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: LoadingWidgetAnimated()) :
            Platform.isAndroid ?
            Card(
              margin: EdgeInsets.only(bottom: 10),
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          AppString.logo, color: AppColors.whiteColor,),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              height: 42,
                              width: 42,
                              child: CircularProgressIndicator(color: AppColors
                                  .whiteColor,
                                strokeWidth: 2,
                                strokeCap: StrokeCap.round,))
                      ),
                    ],
                  )),
            ) :
            CupertinoActivityIndicator(
              color: isDataLoad ? AppColors.whiteColor : AppColors.whiteColor,
              radius: 10,),
            // BuildText.buildText(text: "Loading... Please Wait",color: isDataLoad ? AppColors.blackColor : AppColors.whiteColor,fontFamily: FontFamily.interRegular)
          ],
        ),
      ),
    );
  }
}


class LoadingWidgetAnimated extends StatefulWidget {
  final double? height;
  final double? width;

  const LoadingWidgetAnimated({super.key, this.height, this.width});

  @override
  State<LoadingWidgetAnimated> createState() => _LoadingWidgetAnimatedState();
}

class _LoadingWidgetAnimatedState extends State<LoadingWidgetAnimated> {

  final LoadingController controller = Get.put(LoadingController());

  @override
  void dispose() {
    Get.delete<LoadingController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Lottie.asset('assets/png/Car Animation.json',height: widget.height ?? 120,width: widget.width ?? 150),
            Obx(() => AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final inAnimation =
                Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation);
                final outAnimation = Tween<Offset>(begin: const Offset(0 , 1), end: Offset.zero).animate(animation);

                if (child.key == ValueKey(controller.currentText.value)) {
                  // incoming text → slide from bottom
                  return ClipRect(
                    child: SlideTransition(
                      position: inAnimation,
                      child: child,
                    ),
                  );
                } else {
                  // outgoing text → slide to top
                  return ClipRect(
                    child: SlideTransition(
                      position: outAnimation,
                      child: child,
                    ),
                  );
                }
              },
              child: Padding(
                key: ValueKey(controller.currentText.value),
                padding: const EdgeInsets.all(0.0),
                child: BuildText.buildText(
                  text: controller.currentText.value,
                  size: 15,
                  fontFamily: FontFamily.semiBold,
                ),
              ),
            )),
          ],
        )
      ],
    );
  }
}


