// import 'package:drive_mate/core/utils/text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:skeletonizer/skeletonizer.dart';
//
// import '../constants/color.dart';
// import '../constants/font_family.dart';
// import '../constants/string_define.dart';
// import 'base_image.dart';
// import 'button.dart';
//
// class ShimmerCustom extends StatelessWidget {
//   final Widget child;
//   final bool isLoading;
//   const ShimmerCustom({super.key,required this.child,required this.isLoading});
//
//   @override
//   Widget build(BuildContext context) {
//     return Skeletonizer(
//       containersColor: Colors.grey.shade800,
//       effect: ShimmerEffect(
//         baseColor: Colors.grey.shade700,
//         highlightColor: Colors.grey.shade500,
//         duration: Duration(milliseconds: 1800),
//         begin: Alignment.centerLeft,
//         end: Alignment.centerRight,
//       ),
//       enabled: isLoading,
//       child: child
//     );
//   }
// }
//
// class ShimmerWidgets{
//
//   static final ShimmerWidgets _singleton = ShimmerWidgets._internal();
//   factory ShimmerWidgets() {
//     return _singleton;
//   }
//   ShimmerWidgets._internal();
//
//   static fullScreenShimmer(){
//     return Shimmer.fromColors(
//       period: const Duration(milliseconds: 2000),
//       baseColor: Colors.grey,
//       highlightColor: AppColors.whiteColor,
//       child: Container(
//         width: Get.width,
//         height: Get.height,
//         decoration: BoxDecoration(
//             color: Colors.grey,
//             borderRadius: BorderRadius.circular(15)
//         ),
//       ),
//     );
//   }
//
//   static Widget myDriveShimmer(){
//     return ListView.builder(
//         itemCount: 3,
//         padding: EdgeInsets.zero,
//         physics: const BouncingScrollPhysics(),
//         shrinkWrap: true,
//         itemBuilder: (BuildContext context, index){
//           return Container(
//             padding: EdgeInsets.symmetric(vertical: 20),
//             margin: EdgeInsets.only(bottom: 15),
//             decoration: BoxDecoration(
//                 color: AppColors.clr2C2C2C,
//                 border: Border.all(color: AppColors.textFieldBorderColor),
//                 borderRadius: BorderRadius.circular(12)
//             ),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//                       /// Indicators
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8),
//                         child: Stack(
//                           children: [
//                             Positioned(
//                                 left: 0,
//                                 right: 0,
//                                 top: 18,
//                                 bottom: 18,
//                                 child: SvgPicture.asset(AppString.dottedLineSvg)
//                             ),
//                             Column(
//                               children: [
//                                 SvgPicture.asset(AppString.startLocationSvg),
//                                 buildSizeBox(40.0, 0.0),
//                                 SvgPicture.asset(AppString.destinationLocationSvg),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                       buildSizeBox(0.0, 15.0),
//
//                       /// From/To Locations
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             BuildText.buildText(text: "From",
//                                 size: 12,
//                                 fontFamily: FontFamily.semiBold,
//                                 height: 0.8,
//                                 color: AppColors.clrC8C7CC),
//                             BuildText.buildText(text: "Jaipur",
//                                 size: 17,
//                                 fontFamily: FontFamily.semiBold),
//                             Container(
//                               height: 1,
//                               width: Get.width,
//                               margin: EdgeInsets.symmetric(vertical: 15),
//                               color: AppColors.clr606060,
//                             ),
//                             BuildText.buildText(text: "To",
//                                 size: 12,
//                                 fontFamily: FontFamily.semiBold,
//                                 height: 0.8,
//                                 color: AppColors.clrC8C7CC),
//                             BuildText.buildText(text: "Himachal Pradesh",
//                                 size: 17,
//                                 fontFamily: FontFamily.semiBold),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 buildSizeBox(20.0, 0.0),
//
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12),
//                   child: BaseImage.image(path: AppString.mapDemo),
//                 ),
//                 buildSizeBox(15.0, 0.0),
//
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset(AppString.calendar),
//                         buildSizeBox(0.0, 10.0),
//                         BuildText.buildText(
//                           text: 'Date and time',
//                         ),
//                       ]
//                   ),
//                 ),
//                 buildSizeBox(15.0, 0.0),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   child: CustomButton(
//                     onPressed: () {},
//                     text: "Start Drive",
//                     textStyle: TextStyle(
//                         fontSize: 18, fontFamily: FontFamily.regular),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//     );
//   }
//
//   static Widget blockedUserShimmer(){
//     return Container(
//       decoration: BoxDecoration(
//           color: AppColors.clr2C2C2C,
//           border: Border.all(color: AppColors.clr606060),
//           borderRadius: BorderRadius.circular(12)
//       ),
//       child: ListView.builder(
//           itemCount: 3,
//           padding: EdgeInsets.zero,
//           physics: const AlwaysScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemBuilder: (BuildContext context, index){
//             return Padding(
//               padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 10),
//               child: Row(
//                 children: [
//
//                   /// Image
//                   Container(
//                     height: 52,
//                     width: 52,
//                     alignment: Alignment.center,
//                     clipBehavior: Clip.antiAlias,
//                     decoration: BoxDecoration(
//                       color: AppColors.clr606060,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Image.asset(AppString.userDemo),
//                   ),
//                   buildSizeBox(0.0, 15.0),
//
//                   /// Name
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         BuildText.buildText(text: "Test User",size: 16,fontFamily: FontFamily.semiBold),
//                         buildSizeBox(3.0, 0.0),
//                         BuildText.buildText(text: 'testuser@yopmail.com',size: 12,fontFamily: FontFamily.regular,color: AppColors.clrD6D6D6),
//                       ],
//                     ),
//                   ),
//                   buildSizeBox(0.0, 6.0),
//
//                   /// Unblock
//                   Card(
//                     elevation: 4,
//                     color: AppColors.clr2C2C2C,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                     margin: EdgeInsets.zero,
//                     child: CustomButton(
//                       onPressed: (){},
//                       btnHeight: 28,
//                       btnWidth: 66,
//                       color: AppColors.primaryColor,
//                       isGradient: false,
//                       text: 'Unblock',
//                       textStyle: TextStyle(fontSize: 12,fontFamily: FontFamily.regular),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           }
//       ),
//     );
//   }
// }