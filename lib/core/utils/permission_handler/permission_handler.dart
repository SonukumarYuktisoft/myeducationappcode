// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../../utils/print_log.dart';

// class CheckPermission {
//   static CheckPermission? _instance;
//   factory CheckPermission() => _instance  =  CheckPermission._();

//   CheckPermission._();

//   static Future<Object> checkCameraPermission(BuildContext context) async {
//     bool isCameraPermission = false;
//     await Permission.camera.request().then((value) async {
//       PrintLog.printLog('value: $value');

//       // if(value == PermissionStatus.denied || value == PermissionStatus.permanentlyDenied){
//       //   await showCameraPermissionPopUp(context).then((value) {
//       //     if(value == true){
//       //       openAppSettings();
//       //     }
//       //   } );
//       // }
//     });

//     final status = await Permission.camera.status;
//     PrintLog.printLog('camera permission status: $status');
//     if (status == PermissionStatus.granted) {
//       PrintLog.printLog('Camera Permission granted');
//     }else if (status == PermissionStatus.denied || status == PermissionStatus.permanentlyDenied) {
//       await Permission.camera.request().then((value) async {
//         PrintLog.printLog('value: $value');

//         // if(value == PermissionStatus.denied || value == PermissionStatus.permanentlyDenied){
//         //   await showCameraPermissionPopUp(context).then((value) {
//         //     if(value == true){
//         //       openAppSettings();
//         //     }
//         //   } );
//         // }
//       });
//     }

//     PermissionStatus whenInUse = await Permission.camera.status;
//     if (whenInUse == PermissionStatus.granted) isCameraPermission = true;

//     return isCameraPermission;
//   }

//   static Future<bool> checkLocationPermission(BuildContext context) async {
//     bool isLocationPermission = false;
//     await Permission.location.request().then((value) async {
//       PrintLog.printLog('Location permission status: $value');
      
//       await Permission.locationWhenInUse.request().then((value) async{
//        await Permission.locationAlways.request();
    

//       if(value == PermissionStatus.denied || value == PermissionStatus.permanentlyDenied){
//         // await showLocationPermissionPopUp(context).then((value) {
//         //   if(value == true){
//         //     openAppSettings();
//         //   }
//         // } );
//       }
//     });});

//     PermissionStatus whenInUse = await Permission.locationWhenInUse.status;
//     // if (whenInUse == PermissionStatus.granted || whenInUse == PermissionStatus.limited) isLocationPermission = true;

//     PermissionStatus always = await Permission.locationAlways.status;
//     if (always == PermissionStatus.granted) isLocationPermission = true;
// PrintLog.printLog('always permission $always');
// PrintLog.printLog('always isLocationPermission $isLocationPermission');

//     return isLocationPermission;
//   }


//    static Future<Placemark?> getPlaceMarkWithLatLng({required String latitude,required String longitude}) async {
//     Placemark? placeMark;
//     // await checkLocationPermission(Get.overlayContext!).then((value) async {
//     //   if(value == true){
        
//     //   }
//     // });
//     await placemarkFromCoordinates(double.parse(latitude.toString()), double.parse(longitude.toString())).then((positionValue){
//       placeMark = positionValue[0];
//       PrintLog.printLog("PlaceMark: ${positionValue[0]}");
//       PrintLog.printLog("PlaceMark-country: ${positionValue[0].country}");
//       PrintLog.printLog("PlaceMark-street: ${positionValue[0].street}");
//       PrintLog.printLog("PlaceMark-subLocality: ${positionValue[0].subLocality}");
//       PrintLog.printLog("PlaceMark-postalCode: ${positionValue[0].postalCode}");
//       PrintLog.printLog("PlaceMark-administrativeArea: ${positionValue[0].administrativeArea}");
//       PrintLog.printLog("PlaceMark-locality: ${positionValue[0].locality}");
//       return placeMark;
//     });
//     return placeMark;
//   }
// }