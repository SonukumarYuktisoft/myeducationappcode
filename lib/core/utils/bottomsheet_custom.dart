
import 'package:education/core/constants/color.dart';
import 'package:education/core/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetCustom{

  static BottomSheetCustom? _instance;

  factory BottomSheetCustom() => _instance = BottomSheetCustom._();
  BottomSheetCustom._();

  static showDynamicBottomSheet({required BuildContext context ,required Widget child ,required Function(dynamic) onValue,required AnimationController animationController}) async {
    return await showModalBottomSheet(
      useSafeArea: true,
      enableDrag: false,
      barrierColor: Colors.transparent,
      isDismissible: false,
      transitionAnimationController: animationController,
      isScrollControlled: true,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24.0),
          topLeft: Radius.circular(24.0),
        )
      ),
      context: context,
      backgroundColor: AppColors.whiteColor,
      builder: (builder){
        return SizedBox(
          height: Get.size.height * 0.72,
          width: Get.width,
          child: child);
      }
    ).then(onValue);
  }
  
  static showShareAttachmentBottomSheet({required BuildContext context ,required Function(dynamic) onValue}) async {
    return showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          )
      ),
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder){
        return ShareAttachmentBottomSheet();
      }
    ).then(onValue);
  }

  // static showTrackBottomSheet({required BuildContext context ,required Function(dynamic) onValue, required String trackId}) async {
  //   return showModalBottomSheet(
  //     isDismissible: true,
  //     isScrollControlled: true,
  //     clipBehavior: Clip.antiAlias,
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //           topRight: Radius.circular(20.0),
  //           topLeft: Radius.circular(20.0),
  //         )
  //     ),
  //     context: context,
  //     backgroundColor: AppColors.transparentColor,
  //     builder: (builder){
  //       return TrackScreen(trackId: trackId,);
  //     }
  //   ).then(onValue);
  // }

  static showImagePickerBottomSheet({required BuildContext context,required Function(dynamic) onValue}) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            height: 110,
            padding: const EdgeInsets.only(top: 15,bottom: 15),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop("gallery");
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 8,bottom: 8,left: 35,right: 35),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade800,width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.photo_library,color: Colors.grey.shade800,size: 30,),
                        BuildText.buildText(text: "Gallery"),
                      ],
                    )
                  ),
                ),
                buildSizeBox(0.0,30.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop("camera");
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 8,bottom: 8,left: 35,right: 35),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade800,width: 2),
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.photo_camera,color: Colors.grey.shade800,size: 30,),
                        BuildText.buildText(text: "Camera"),
                      ],
                    )
                  ),
                ),
              ],
            )
          ),
        );
      }).then(onValue);
  } 
}

class ShareAttachmentBottomSheet extends StatefulWidget {
  
  ShareAttachmentBottomSheet({super.key});

  @override
  State<ShareAttachmentBottomSheet> createState() => _ShareAttachmentBottomSheetState();
}

class _ShareAttachmentBottomSheetState extends State<ShareAttachmentBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop("photo"),
                        child: BuildText.buildText(text: 'Photo',color: Colors.blue,weight: FontWeight.w600,size: 15)),
                      buildSizeBox(8.0, 0.0),
                      const Divider(),
                      buildSizeBox(8.0, 0.0),
                      InkWell(
                        onTap: () => Navigator.of(context).pop("document"),
                        child: BuildText.buildText(text: 'Document',color: Colors.blue,weight: FontWeight.w600,size: 15)),
                    ],
                  ),
                ),
              ),
              buildSizeBox(15.0, 0.0),

              InkWell(
                onTap: () => Get.back(),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: BuildText.buildText(text: 'Cancel',color: Colors.blue,weight: FontWeight.w600,size: 15),
                ),
              )
            ],
          )
        ),
      ],
    );
  }
}
