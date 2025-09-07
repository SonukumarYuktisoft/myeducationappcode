//
// import 'package:drive_mate/core/utils/print_log.dart';
// import 'package:drive_mate/core/utils/text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import '../constants/color.dart';
// import '../constants/font_family.dart';
//
// class RefreshCTRL{
//
//   static Widget refresh({Key? key,required BuildContext context,required Widget child,required Function() onLoading,required Function() onRefresh,required RefreshController refreshCtrl,bool? isLoading}){
//     return SmartRefresher(
//       key: key,
//       enablePullDown: true,
//       enablePullUp: true,
//       header: WaterDropHeader(
//         waterDropColor: AppColors.primaryColor,
//         refresh: CupertinoActivityIndicator(color: AppColors.whiteColor,),
//         complete: refreshCompletedWidget(context: context),
//         completeDuration: const Duration(milliseconds: 100),
//       ),
//       footer: CustomFooter(
//         height: 70.0,
//         loadStyle: LoadStyle.ShowAlways,
//         builder: (BuildContext context,LoadStatus? mode){
//           PrintLog.printLog("Mode : $mode");
//           return
//           isLoading == true ?
//           Padding(
//             padding: const EdgeInsets.only(top: 15),
//             child:
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CupertinoActivityIndicator(color: AppColors.whiteColor),
//                 buildSizeBox(0.0, 10.0),
//                 BuildText.buildText(text: "Loading",color: AppColors.whiteColor,size: 14,fontFamily: FontFamily.medium)
//
//               ],
//             ),
//           )
//           //  : mode == LoadStatus.noMore ?
//           // BuildText.buildText(text: "No more data available",color: AppColors.whiteColor,size: 15,fontFamily: FontFamily.interMedium)
//           // : mode == LoadStatus.failed ?
//           // BuildText.buildText(text: "Load Failed! Try again!",color: AppColors.whiteColor,size: 15,fontFamily: FontFamily.interMedium)
//            : const SizedBox.shrink();
//         },
//       ),
//       controller: refreshCtrl,
//       onRefresh: onRefresh,
//       onLoading: onLoading,
//       child: child,
//     );
//   }
//
//   static Widget refreshCompletedWidget({required BuildContext context}){
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         // Text("Refresh completed",style: TextStyle(fontFamily: FontFamily.interMedium,fontSize: 14.0,color: AppColors.whiteColor),textAlign: TextAlign.center),
//         // Icon(CupertinoIcons.checkmark_alt,color: AppColors.whiteColor)
//       ],
//     );
//   }
// }