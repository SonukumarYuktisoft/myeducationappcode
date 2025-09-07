// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'permission_widget.dart';
//
// bool isAvlPopup = false;
// class PermissionController extends GetxController{
//
//   bool isLocation = false,isCamera = false,isMicroPhone = false;
//
//   Future<bool> checkLocationPermissionCustom()async{
//     LocationPermission permission = await Geolocator.checkPermission();
//
//     if (permission != LocationPermission.always) {
//       Get.toNamed(RouteNavigation.accessLocationScreenroute, arguments: AccessLocationScreen(isFirstTime: false));
//     } else {
//       PrintLog.printLog("::::Location Always On Permission Granted::::");
//       return true;
//     }
//     return false;
//   }
//
//   Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
//       Placemark placemark = placemarks[0];
//       return '${placemark.subLocality}${placemark.subLocality != null && placemark.subLocality != "" ? ", ":""}${placemark.locality}${placemark.locality != null && placemark.locality != "" ? ", ":""}${placemark.administrativeArea}${placemark.administrativeArea != null && placemark.administrativeArea != "" ? ", ":""}${placemark.country}';
//     } catch (e) {
//       PrintLog.printLog('Error: $e');
//       return "";
//     }
//   }
//
//   Future<Position?> determinePosition() async {
//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         return _emptyPosition();
//       }
//
//       LocationPermission permission = await Geolocator.checkPermission();
//
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//       }
//
//       if (permission == LocationPermission.deniedForever) {
//         permission = await Geolocator.requestPermission();
//         bool hasShown = AppSecureStorage.getBoolValueFromSharedPref(variableName: AppSecureStorage.kLocationPopUpShow) ?? false;
//         if((hasShown)){
//           // openAppSettings();
//           // showPermissionPopUp(
//           //     context: Get.context!,
//           //     title: "Allow Location Access",
//           //     subTitle: "To track live rider updates and ensure accurate real-time location sharing, we need access to your location even when the app is in the background. Please tap continue when prompted, or go to Settings > Location > Always to enable background access."
//           // );
//         }
//
//         return _emptyPosition();
//       }
//       if (permission == LocationPermission.whileInUse) {
//         // openAppSettings();
//         permission = await Geolocator.requestPermission();
//
//         bool hasShown = AppSecureStorage.getBoolValueFromSharedPref(variableName: AppSecureStorage.kLocationPopUpShow) ?? false;
//         if((!hasShown)){
//           // showPermissionPopUp(
//           //     context: Get.context!,
//           //     title: "Allow Location Access",
//           //     subTitle: "To track live rider updates and ensure accurate real-time location sharing, we need access to your location even when the app is in the background. Please tap continue when prompted, or go to Settings > Location > Always to enable background access."
//           // );
//         }
//       }
//
//       if (permission != LocationPermission.always && permission != LocationPermission.whileInUse) {
//         return _emptyPosition();
//       }
//
//       // update(); // Uncomment this if needed
//       return await Geolocator.getCurrentPosition();
//     } catch (e) {
//       PrintLog.printLog("Exception : $e");
//       return _emptyPosition();
//     }
//   }
//
//   Position _emptyPosition() {
//     return Position(latitude: 0.0, longitude: 0.0, timestamp: DateTime.now(), accuracy: 0, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0, altitudeAccuracy: 0, headingAccuracy: 0,);
//   }
//
//
//   /// All Permission Request
//   Future<void> allPermissionRequest()async{
//     await notificationPermissionRequest().then((value) async {
//       await locationPermissionRequest().then((value) async {
//         await cameraPermissionRequest().then((value) async {
//           await micPermissionRequest().then((value) async {
//
//           });
//         });
//       });
//     });
//   }
//
//   /// Notification
//   Future<void> notificationPermissionRequest()async{
//     await Permission.notification.isDenied.then((value) async {
//       if (value) {
//         await Permission.notification.request();
//       }
//     });
//   }
//
//   /// Location
//   Future<bool> locationPermissionRequest()async{
//     LocationPermission permission;
//     permission = await Geolocator.checkPermission();
//     if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
//       // await showPermissionPopUp(
//       //   context: Get.overlayContext!,
//       //   title: PermissionHandlerWidget.kPermission,
//       //   subTitle: PermissionHandlerWidget.kLocationPermissionSubtitle
//       // );
//       permission = await Geolocator.requestPermission();
//     }
//     permission = await Geolocator.checkPermission();
//     if(permission != LocationPermission.denied && permission != LocationPermission.deniedForever){
//       return true;
//     }
//     return false;
//   }
//
//   Future<void> requestLocationPermissions() async {
//     var status = await Permission.locationAlways.request();
//
//     if (status.isGranted) {
//       var backgroundStatus = await Permission.locationAlways.request();
//       if (backgroundStatus.isGranted) {
//         PrintLog.printLog("Background location granted");
//       } else {
//         PrintLog.printLog("Background location denied");
//       }
//     } else {
//         PrintLog.printLog("Location permission denied");
//     }
//   }
//
//   Future<void> requestLocationPermissioniOS() async {
//     var whenInUseStatus = await Permission.locationWhenInUse.status;
//
//     if (whenInUseStatus.isDenied || whenInUseStatus.isRestricted) {
//       whenInUseStatus = await Permission.locationWhenInUse.request();
//     }
//
//     if (whenInUseStatus.isGranted) {
//       // Request always permission
//       var alwaysStatus = await Permission.locationAlways.request();
//
//       if (alwaysStatus.isGranted) {
//         PrintLog.printLog("✅ Always Location Granted");
//       } else {
//         PrintLog.printLog("⚠️ Always Location Denied");
//       }
//     } else if (whenInUseStatus.isPermanentlyDenied) {
//       PrintLog.printLog("❌ WhenInUse permanently denied. Opening settings...");
//       openAppSettings();
//     }
//   }
//
//
//
//
//
//   /// Camera
//   Future<void> cameraPermissionRequest()async{
//     final status = await Permission.camera.status;
//     if(status == PermissionStatus.granted){
//       isCamera = true;
//       update();
//     }else{
//       await Permission.camera.request().then((value) async {
//         if(value == PermissionStatus.denied || value == PermissionStatus.permanentlyDenied){
//           await showPermissionPopUp(
//               context: Get.overlayContext!,
//               title: PermissionHandlerWidget.kPermission,
//               subTitle: PermissionHandlerWidget.kCameraPermissionSubtitle
//           );
//         }
//       });
//     }
//
//   }
//
//   /// Micro Phone
//   Future<void> micPermissionRequest()async{
//     final status = await Permission.microphone.status;
//     if(status == PermissionStatus.granted){
//       isMicroPhone = true;
//       update();
//     }else{
//       await Permission.microphone.request().then((value) async {
//         if(value == PermissionStatus.denied || value == PermissionStatus.permanentlyDenied){
//           await showPermissionPopUp(
//               context: Get.overlayContext!,
//               title: PermissionHandlerWidget.kPermission,
//               subTitle: PermissionHandlerWidget.kMicroPhonePermissionSubtitle
//           );
//         }
//       });
//     }
//   }
//
//
//
//   onTapLocation({required BuildContext context}) async {
//     PrintLog.printLog("Clicked on Location::::::::");
//
//     final status = await Permission.locationAlways.status;
//     if(status == PermissionStatus.granted){
//       isLocation = true;
//     }else if (status == PermissionStatus.denied || status == PermissionStatus.permanentlyDenied) {
//       await Permission.locationAlways.request().then((value) async {
//         PrintLog.printLog('value: $value');
//
//         if(value == PermissionStatus.granted){
//           isLocation = true;
//         }else if(value == PermissionStatus.denied || value == PermissionStatus.permanentlyDenied){
//           await showPermissionPopUp(
//               context: Get.context!,
//               title: PermissionHandlerWidget.kPermission,
//               subTitle: PermissionHandlerWidget.kLocationPermissionSubtitle
//           );
//         }
//       });
//     }
//     update();
//   }
//
//   onTapCamera({required BuildContext context}) async {
//     PrintLog.printLog("Clicked on Camera::::::::");
//     final status = await Permission.camera.status;
//     if(status == PermissionStatus.granted){
//       isCamera = true;
//     }else if (status == PermissionStatus.denied || status == PermissionStatus.permanentlyDenied) {
//       await Permission.camera.request().then((value) async {
//         PrintLog.printLog('value: $value');
//
//         if(value == PermissionStatus.granted){
//           isCamera = true;
//         }else if(value == PermissionStatus.denied || value == PermissionStatus.permanentlyDenied){
//           await showPermissionPopUp(
//               context: Get.context!,
//               title: PermissionHandlerWidget.kPermission,
//               subTitle: PermissionHandlerWidget.kCameraPermissionSubtitle
//           );
//         }
//       });
//     }
//     update();
//   }
//
//   onTapMicroPhone({required BuildContext context}) async {
//     PrintLog.printLog("Clicked on MicroPhone::::::::");
//     final status = await Permission.microphone.status;
//     if(status == PermissionStatus.granted){
//       isMicroPhone = true;
//     }else if (status == PermissionStatus.denied || status == PermissionStatus.permanentlyDenied) {
//       await Permission.microphone.request().then((value) async {
//         PrintLog.printLog('value: $value');
//
//         if(value == PermissionStatus.granted){
//           isMicroPhone = true;
//         }else if(value == PermissionStatus.denied || value == PermissionStatus.permanentlyDenied){
//           await showPermissionPopUp(
//               context: Get.context!,
//               title: PermissionHandlerWidget.kPermission,
//               subTitle: PermissionHandlerWidget.kMicroPhonePermissionSubtitle
//           );
//         }
//       });
//     }
//     update();
//   }
//
//
//   Future<void> showPermissionPopUp({required BuildContext context,required String title,required String subTitle}) async{
//     return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (ctx) => PopScope(
//         canPop: false,
//         child: CupertinoAlertDialog(
//           title: Padding(
//             padding: const EdgeInsets.only(bottom: 10),
//             child: Text(
//                 title
//                 ,style: TextStyle(color: Colors.grey,fontFamily: FontFamily.interBold,fontSize: 20,letterSpacing: PermissionHandlerWidget.latterSpacing)
//             ),
//           ),
//           content: Text(
//             subTitle
//             ,style: TextStyle(color: Colors.grey,fontFamily: FontFamily.interRegular,fontSize: 14,letterSpacing: PermissionHandlerWidget.latterSpacing),
//           ),
//           actions: <Widget>[
//             Center(
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.of(ctx).pop(false);
//                 },
//                 child: Text(
//                     "Back"
//                     ,style: TextStyle(color: Colors.blue,fontFamily: FontFamily.interMedium,fontSize: 14,letterSpacing: PermissionHandlerWidget.latterSpacing)
//                 ),
//               ),
//             ),
//             Center(
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.of(ctx).pop(true);
//                 },
//                 child: Text(
//                     "Continue"
//                     ,style: TextStyle(color: Colors.blue,fontFamily: FontFamily.interMedium,fontSize: 14,letterSpacing: PermissionHandlerWidget.latterSpacing)
//                 ),
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     ).then((value)async{
//       if(value == true){
//         Get.back();
//         await Future.delayed(Duration(milliseconds: 200));
//         Geolocator.openLocationSettings();
//       }else{
//         Get.back();
//       }
//     });
//   }
//
//   Future<void> permissionInfoPopUp({required BuildContext context,required String title,required String subTitle}) async{
//     return await showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (ctx) => PopScope(
//         canPop: false,
//         child: CupertinoAlertDialog(
//           title: Padding(
//             padding: const EdgeInsets.only(bottom: 10),
//             child: Text(
//                 title
//                 ,style: TextStyle(color: Colors.grey,fontFamily: FontFamily.interBold,fontSize: 20,letterSpacing: PermissionHandlerWidget.latterSpacing)
//             ),
//           ),
//           content: Text(
//             subTitle
//             ,style: TextStyle(color: Colors.grey,fontFamily: FontFamily.interRegular,fontSize: 14,letterSpacing: PermissionHandlerWidget.latterSpacing),
//           ),
//           actions: <Widget>[
//             Center(
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.of(ctx).pop(true);
//                 },
//                 child: Text(
//                     "Continue"
//                     ,style: TextStyle(color: Colors.blue,fontFamily: FontFamily.interMedium,fontSize: 14,letterSpacing: PermissionHandlerWidget.latterSpacing)
//                 ),
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     ).then((value)async{
//       // if(value == true){
//       //   Get.back();
//       //   await Future.delayed(Duration(milliseconds: 200));
//       //   Geolocator.openLocationSettings();
//       // }else{
//       //   Get.back();
//       // }
//     });
//   }
//
// }