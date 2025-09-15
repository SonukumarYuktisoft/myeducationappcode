import 'package:education/core/constants/font_family.dart';
import 'package:education/core/utils/print_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'permission_widget.dart';

bool isAvlPopup = false;
class PermissionController extends GetxController{

  bool isLocation = false,isCamera = false,isMicroPhone = false;

  /// Notification
  Future<void> notificationPermissionRequest()async{
    await Permission.notification.isDenied.then((value) async {
      if (value) {
        await Permission.notification.request();
      }
    });
  }

  /// Camera
  Future<void> cameraPermissionRequest()async{
    final status = await Permission.camera.status;
    if(status == PermissionStatus.granted){
      isCamera = true;
      update();
    }else{
      await Permission.camera.request().then((value) async {
        if(value == PermissionStatus.denied || value == PermissionStatus.permanentlyDenied){
          await showPermissionPopUp(
              context: Get.overlayContext!,
              title: PermissionHandlerWidget.kPermission,
              subTitle: PermissionHandlerWidget.kCameraPermissionSubtitle
          );
        }
      });
    }

  }

  /// Micro Phone
  Future<void> micPermissionRequest()async{
    final status = await Permission.microphone.status;
    if(status == PermissionStatus.granted){
      isMicroPhone = true;
      update();
    }else{
      await Permission.microphone.request().then((value) async {
        if(value == PermissionStatus.denied || value == PermissionStatus.permanentlyDenied){
          await showPermissionPopUp(
              context: Get.overlayContext!,
              title: PermissionHandlerWidget.kPermission,
              subTitle: PermissionHandlerWidget.kMicroPhonePermissionSubtitle
          );
        }
      });
    }
  }

  onTapCamera({required BuildContext context}) async {
    PrintLog.printLog("Clicked on Camera::::::::");
    final status = await Permission.camera.status;
    if(status == PermissionStatus.granted){
      isCamera = true;
    }else if (status == PermissionStatus.denied || status == PermissionStatus.permanentlyDenied) {
      await Permission.camera.request().then((value) async {
        PrintLog.printLog('value: $value');

        if(value == PermissionStatus.granted){
          isCamera = true;
        }else if(value == PermissionStatus.denied || value == PermissionStatus.permanentlyDenied){
          await showPermissionPopUp(
              context: Get.context!,
              title: PermissionHandlerWidget.kPermission,
              subTitle: PermissionHandlerWidget.kCameraPermissionSubtitle
          );
        }
      });
    }
    update();
  }

  onTapMicroPhone({required BuildContext context}) async {
    PrintLog.printLog("Clicked on MicroPhone::::::::");
    final status = await Permission.microphone.status;
    if(status == PermissionStatus.granted){
      isMicroPhone = true;
    }else if (status == PermissionStatus.denied || status == PermissionStatus.permanentlyDenied) {
      await Permission.microphone.request().then((value) async {
        PrintLog.printLog('value: $value');

        if(value == PermissionStatus.granted){
          isMicroPhone = true;
        }else if(value == PermissionStatus.denied || value == PermissionStatus.permanentlyDenied){
          await showPermissionPopUp(
              context: Get.context!,
              title: PermissionHandlerWidget.kPermission,
              subTitle: PermissionHandlerWidget.kMicroPhonePermissionSubtitle
          );
        }
      });
    }
    update();
  }


  Future<void> showPermissionPopUp({required BuildContext context,required String title,required String subTitle}) async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => PopScope(
        canPop: false,
        child: CupertinoAlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
                title
                ,style: TextStyle(color: Colors.grey,fontFamily: FontFamily.bold,fontSize: 20,letterSpacing: PermissionHandlerWidget.latterSpacing)
            ),
          ),
          content: Text(
            subTitle
            ,style: TextStyle(color: Colors.grey,fontFamily: FontFamily.regular,fontSize: 14,letterSpacing: PermissionHandlerWidget.latterSpacing),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: Text(
                    "Back"
                    ,style: TextStyle(color: Colors.blue,fontFamily: FontFamily.medium,fontSize: 14,letterSpacing: PermissionHandlerWidget.latterSpacing)
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: Text(
                    "Continue"
                    ,style: TextStyle(color: Colors.blue,fontFamily: FontFamily.medium,fontSize: 14,letterSpacing: PermissionHandlerWidget.latterSpacing)
                ),
              ),
            ),

          ],
        ),
      ),
    ).then((value)async{
      
    });
  }

  Future<void> permissionInfoPopUp({required BuildContext context,required String title,required String subTitle}) async{
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => PopScope(
        canPop: false,
        child: CupertinoAlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
                title
                ,style: TextStyle(color: Colors.grey,fontFamily: FontFamily.bold,fontSize: 20,letterSpacing: PermissionHandlerWidget.latterSpacing)
            ),
          ),
          content: Text(
            subTitle
            ,style: TextStyle(color: Colors.grey,fontFamily: FontFamily.regular,fontSize: 14,letterSpacing: PermissionHandlerWidget.latterSpacing),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: Text(
                    "Continue"
                    ,style: TextStyle(color: Colors.blue,fontFamily: FontFamily.medium,fontSize: 14,letterSpacing: PermissionHandlerWidget.latterSpacing)
                ),
              ),
            ),

          ],
        ),
      ),
    ).then((value)async{
      // if(value == true){
      //   Get.back();
      //   await Future.delayed(Duration(milliseconds: 200));
      //   Geolocator.openLocationSettings();
      // }else{
      //   Get.back();
      // }
    });
  }

}