import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main.dart';


/// msgController
class FirebaseMessagingCustom {

  // static FirebaseMessaging? _instance;
  //
  // static Future<FirebaseMessaging?> getInstance() async {
  //   if (_instance == null) {
  //     // await setUpNotification();
  //     _instance = FirebaseMessaging.instance;
  //     PrintLog.printLog("FirebaseMessaging init success:::::::");
  //     return _instance;
  //   }
  //   return _instance;
  // }
  //
  // static Future<String?> getToken() async {
  //   try{
  //     return await _instance?.getToken();
  //   }catch(e){
  //     PrintLog.printLog("Error : $e");
  //     return null;
  //   }
  // }
  //
  // static Future<String?> getApnsToken() async {
  //   return await _instance?.getAPNSToken();
  // }
  //
  // static Future<bool?> isTest() async {
  //   return  await _instance?.isSupported();
  // }
  //
  // ///Mark - Notification
  // static AndroidNotificationChannel channel = const AndroidNotificationChannel(
  //     'high_importance_channel', //id
  //     'High Importance Notifications', //title
  //     importance: Importance.high,
  //     playSound: true
  // );
  //
  // static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //
  //
  // static Future<void> setUpNotification() async {
  //
  //   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  //
  //   // Initialize local notifications plugin
  //   const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  //   final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
  //   final InitializationSettings initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsIOS,
  //   );
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  //
  //   if (Platform.isAndroid) {
  //     await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  //   }
  //
  //   if (_instance != null) {
  //     await _instance!.setForegroundNotificationPresentationOptions(
  //       alert: true,
  //       badge: true,
  //       sound: true,
  //     );
  //   }
  //
  //   await notificationFuncCall();
  // }
  //
  // static Future<void> notificationFuncCall()async{
  //
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;
  //
  //   /// Request Permission
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  //
  //
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     PrintLog.printLog('User granted permission');
  //   } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  //     PrintLog.printLog('User granted provisional permission');
  //   } else {
  //     PrintLog.printLog('User declined or has not accepted permission');
  //   }
  //
  //
  //   // For both iOS and Android
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //     RemoteNotification? notification = message.notification;
  //     PrintLog.printLog("::::Notification Received::::");
  //     PrintLog.printLog("Body Data: ${message.data}");
  //
  //     if (notification == null) {
  //       return;
  //     }
  //
  //     // For iOS, let FCM handle the notification display automatically
  //     if (Platform.isIOS) {
  //       msgController.add(1);
  //       PrintLog.printLog("iOS notification handled by FCM");
  //       return;
  //     }
  //
  //     // For Android, show local notification
  //     if (Platform.isAndroid) {
  //       AndroidNotification? android = message.notification?.android;
  //       if (android != null) {
  //         msgController.add(1);
  //         await flutterLocalNotificationsPlugin.show(
  //           notification.hashCode,
  //           notification.title,
  //           notification.body,
  //           NotificationDetails(
  //             android: AndroidNotificationDetails(
  //               channel.id,
  //               channel.name,
  //               color: Colors.transparent,
  //               playSound: true,
  //               icon: "@mipmap/ic_launcher",
  //             ),
  //           ),
  //         );
  //       }
  //     }
  //   });
  //
  //   /// On Background :::
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     Map<String, dynamic> notificationData = message.data;
  //     handleClick(notificationData);
  //   });
  // }
  //
  // static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  //   msgController.add(1);
  //   if(message.data.isNotEmpty) {
  //     handleClick(message.data);
  //     PrintLog.printLog("Notification value added in ctr....Background");
  //   }
  // }
  //
  // static Future<void> checkInitialMessage() async {
  //   RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  //   if (initialMessage != null) {
  //     PrintLog.printLog("Initial Notification On App Start : ${initialMessage.data}");
  //     handleClick(initialMessage.data);
  //   }
  // }
  //
  // /// Handle Notification Banner Click
  // static handleClick(Map<String,dynamic> data) async {
  //   PrintLog.printLog("welcome to the Shark Bets to this page");
  //   PrintLog.printLog(data['type']);
  //   PrintLog.printLog(data);
  //   String login = AppSecureStorage.getStringFromSharedPref(variableName: AppSecureStorage.kIsLogin) ?? "";
  //
  //   if(login != "true"){
  //     Get.offAllNamed(RouteNavigation.loginScreenRoute);
  //     return;
  //   }
  //
  //   if (data["type"].toString().toLowerCase() == "invitation") {
  //     Get.toNamed(RouteNavigation.notificationScreenRoute);
  //
  //   }else if(data["type"].toString().toLowerCase() == "rider_start"){
  //     String rideId = data["parma"];
  //
  //     if(rideId != ""){
  //       await Future.delayed(Duration(milliseconds: 500),(){
  //         RidesController controller = Get.isRegistered<RidesController>() ? Get.find<RidesController>() : Get.put(RidesController());
  //         controller.selectedRideId = rideId;
  //         controller.mapType = AppString.kMapTypeRides;
  //         Get.toNamed(RouteNavigation.mapScreenRoute,arguments: MapScreen(rideId: rideId, type: AppString.kMapTypeRides));
  //       });
  //     }
  //
  //   }else if(data["type"].toString().toLowerCase() == "rider_end"){
  //     DashboardController controller = Get.isRegistered<DashboardController>() ? Get.find<DashboardController>() : Get.put(DashboardController());
  //
  //     if(Get.currentRoute != RouteNavigation.dashboardScreenRoute){
  //       // Get.offAllNamed(RouteNavigation.dashboardScreenRoute, arguments: 1);
  //     }
  //
  //     controller.changePageIndex(1);
  //     await Future.delayed(Duration(milliseconds: 500),(){
  //       RidesController controller = Get.isRegistered<RidesController>() ? Get.find<RidesController>() : Get.put(RidesController());
  //       controller.tabController.index = 2;
  //       controller.update();
  //       ToastCustom.showSnackBar(subtitle: "Your ride has been ended.",isSuccess: true);
  //       controller.myRidesApi(pageNo: 1, type: 2);
  //     });
  //
  //   }else if(data["type"].toString().toLowerCase() == "crash" || data["type"].toString().toLowerCase() == "helps"){
  //     // Get.offAllNamed(RouteNavigation.dashboardScreenRoute,arguments: 0);
  //   }
  // }

}

// DashboardController controller = Get.isRegistered<DashboardController>() ? Get.find<DashboardController>() : Get.put(DashboardController());
      // controller.changePageIndex(1);