// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../constants/font_family.dart';
// import 'permission_controller.dart';
// import 'permission_widget.dart';
//
// // ignore: must_be_immutable
// class PermissionHandler extends StatefulWidget {
//   bool? isShowBackBtn;
//   PermissionHandler({super.key,this.isShowBackBtn});
//
//   @override
//   State<PermissionHandler> createState() => _PermissionHandlerState();
// }
//
// class _PermissionHandlerState extends State<PermissionHandler> {
//
//   PermissionController ctrl = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//         init: ctrl,
//         builder: (data){
//           bool isBack = data.isLocation == true && data.isCamera == true && data.isMicroPhone == true;
//           return Scaffold(
//             backgroundColor: PermissionHandlerWidget.whiteColor,
//             appBar: widget.isShowBackBtn == true ?
//             AppBar(
//               backgroundColor: PermissionHandlerWidget.whiteColor,
//               leading: IconButton(
//                   onPressed: ()=>Navigator.pop(context),
//                   icon: const Icon(Icons.clear,size: 35,color: Colors.black,)
//               ),
//               elevation: 0,
//             ) : null,
//             bottomNavigationBar: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//
//                     /// Data Safe Title
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(Icons.health_and_safety_outlined,color: PermissionHandlerWidget.greenColor,size: 18,),
//                         const SizedBox(width: 5),
//                         Flexible(
//                           fit: FlexFit.loose,
//                           child: Text(
//                             PermissionHandlerWidget.kAllMandateTitle
//                             ,style: TextStyle(color: PermissionHandlerWidget.subTitleColor,fontFamily: FontFamily.interRegular,fontSize: 11),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 10),
//
//                     /// Allow btn
//                     PermissionHandlerWidget.bottomNavigationStyle(
//                       onPressed: ()=> isBack ? Get.back():data.allPermissionRequest(),
//                       radius: 5,
//                       splashColor: PermissionHandlerWidget.whiteColor,
//                       title: isBack ? PermissionHandlerWidget.kOk:PermissionHandlerWidget.kAllow,
//                       minWidth: MediaQuery.of(context).size.width,
//                       bgColor: PermissionHandlerWidget.blackColor,
//                       titleColor: PermissionHandlerWidget.whiteColor,
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             body: SafeArea(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   widget.isShowBackBtn == true ?
//                       const SizedBox(height: 0):const SizedBox(height: 10),
//
//                   /// Title
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: Text(
//                         PermissionHandlerWidget.kTitle
//                         ,style: TextStyle(color: PermissionHandlerWidget.titleColor,fontFamily: FontFamily.interBold,fontSize: 20,letterSpacing: PermissionHandlerWidget.latterSpacing)
//                     ),
//                   ),
//
//                   /// Sub Title
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: Text(
//                       PermissionHandlerWidget.kSubTitle
//                       ,style: TextStyle(color: PermissionHandlerWidget.subTitleColor,fontFamily: FontFamily.interRegular,fontSize: 14,letterSpacing: PermissionHandlerWidget.latterSpacing),
//                     ),
//                   ),
//
//                   const Divider(thickness: 1),
//
//
//                   Expanded(
//                     child: ListView(
//                       physics: const ClampingScrollPhysics(),
//                       padding: const EdgeInsets.only(left: 15,right: 15,bottom: 50,top: 30),
//                       shrinkWrap: true,
//                       children: [
//
//                         /// Location
//                         PermissionHandlerWidget.listWidget(
//                           context: context,
//                           leading: const Icon(Icons.my_location_rounded),
//                           title: PermissionHandlerWidget.kLocation,
//                           subTitle: PermissionHandlerWidget.kLocationPermissionSubtitle,
//                           checkBoxValue: ctrl.isLocation,
//                           onTap: ()=>ctrl.onTapLocation(context: context),
//                         ),
//
//                         /// Camera
//                         PermissionHandlerWidget.listWidget(
//                           context: context,
//                           leading: const Icon(Icons.camera_alt_outlined),
//                           title: PermissionHandlerWidget.kCamera,
//                           subTitle: PermissionHandlerWidget.kCameraPermissionSubtitle,
//                           checkBoxValue: ctrl.isCamera,
//                           onTap: ()=>ctrl.onTapCamera(context: context),
//                         ),
//
//                         /// Microphone
//                         PermissionHandlerWidget.listWidget(
//                           context: context,
//                           leading: const Icon(Icons.perm_camera_mic_outlined),
//                           title: PermissionHandlerWidget.kMicrophone,
//                           subTitle: PermissionHandlerWidget.kMicroPhonePermissionSubtitle,
//                           checkBoxValue: ctrl.isMicroPhone,
//                           onTap: ()=>ctrl.onTapMicroPhone(context: context),
//                         ),
//
//
//
//
//
//
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//
//           );
//         }
//     );
//
//   }
//
//
//
// }
