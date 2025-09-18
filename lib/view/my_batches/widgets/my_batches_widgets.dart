// import 'package:education/core/constants/color.dart';
// import 'package:education/core/constants/font_family.dart';
// import 'package:education/core/constants/font_style.dart';
// import 'package:education/core/utils/text.dart';
// import 'package:education/view/my_batches/course_controller/course_controller.dart';
// import 'package:education/view/my_batches/widgets/my_batches_chip.dart';
// import 'package:education/view/my_batches/widgets/my_batches_kv.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class MyBatchesWidgets {
//   static const String myBatch = 'My Batch';
//   // static Widget _buildOverviewCard(CourseOverview item, Function() onTap) {
//   // static Widget buildOverviewCard({
//   //   Course ?item,
//   //   void Function()? onTap,}) {
//   //   return GestureDetector(
//   //     onTap: onTap,
//   //     child: Container(
//   //       margin: const EdgeInsets.only(bottom: 12),
//   //       padding: const EdgeInsets.all(16),
//   //       height: 200,
//   //       decoration: BoxDecoration(
//   //         image: DecorationImage(
//   //           image: AssetImage(item!.banner),
//   //           fit: BoxFit.cover,
//   //         ),
//   //         color: AppColors.whiteColor,
//   //         borderRadius: BorderRadius.circular(12),
//   //         boxShadow: [
//   //           BoxShadow(
//   //             color: Colors.grey.withOpacity(0.08),
//   //             blurRadius: 8,
//   //             offset: const Offset(0, 2),
//   //           ),
//   //         ],
//   //         border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.5)),
//   //       ),
//   //       // child: Column(
//   //       //   crossAxisAlignment: CrossAxisAlignment.start,
//   //       //   children: [
//         //     Row(
//         //       crossAxisAlignment: CrossAxisAlignment.start,
//         //       children: [
//         //         Container(
//         //           width: 56,
//         //           height: 56,
//         //           decoration: BoxDecoration(
//         //             color: AppColors.primaryColor.withOpacity(0.1),
//         //             borderRadius: BorderRadius.circular(8),
//         //           ),
//         //           child: Icon(Icons.menu_book, color: AppColors.primaryColor),
//         //         ),
//         //         const SizedBox(width: 12),
//         //         Expanded(
//         //           child: Column(
//         //             crossAxisAlignment: CrossAxisAlignment.start,
//         //             children: [
//         //               Text(
//         //                 item.name,
//         //                 style: TextStyleCustom.headingStyle(
//         //                   fontSize: 16,
//         //                   color: AppColors.blackColor,
//         //                 ),
//         //               ),
//         //               const SizedBox(height: 6),
//         //               Wrap(
//         //                 spacing: 6,
//         //                 runSpacing: -8,
//         //                 children:
//         //                     item.categories
//         //                         .map((c) => _chip(c, AppColors.primaryColor))
//         //                         .toList(),
//         //               ),
//         //             ],
//         //           ),
//         //         ),
//         //       ],
//         //     ),
//         //     const SizedBox(height: 12),
//         //     _kv('Start date', item.startDate),
//         //     const SizedBox(height: 8),
//         //     _kv('Duration', item.duration),
//         //     const SizedBox(height: 8),
//         //     _kv('Teacher', item.teacher),
//         //     const SizedBox(height: 8),
//         //     _kv('Paid', item.isPaid ? 'Yes' : 'No'),
//         //   ],
//   //       // ),
//   //     ),
//   //   );
//   // }

//  static  Widget buildOverviewCardDetail(Course item) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           margin: const EdgeInsets.only(bottom: 12,left: 15,right: 15, top: 15),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.grey.shade100,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.08),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//             border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.5)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               BuildText.buildText(text: "Course Overview"),
//               const SizedBox(height: 12),
//                Container(
//             margin: const EdgeInsets.only(bottom: 12),
//             padding: const EdgeInsets.all(16),
//             height: 200,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/png/trending_courses_img.jpg'),
//                 fit: BoxFit.cover,
//               ),
//               color: AppColors.whiteColor,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.08),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//               border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.5)),
//             ),),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 56,
//                     height: 56,
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Icon(Icons.menu_book, color: AppColors.primaryColor),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           item.title,
//                           style: TextStyleCustom.headingStyle(
//                             fontSize: 16,
//                             color: AppColors.blackColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               MyBatchesKv(label: 'Start date', value: item.startDate),
//               const SizedBox(height: 12),
//               MyBatchesKv(label: 'Duration', value: item.duration),
//               const SizedBox(height: 12),
//               MyBatchesKv(label: 'Teacher', value: item.instructor),
//               const SizedBox(height: 12),
//               MyBatchesKv(label: 'Paid', value: item.isPaid ? 'Yes' : 'No'),
//               const SizedBox(height: 20),

//               // kv('Start date', item.startDate),
//               // const SizedBox(height: 12),
//               // kv('Duration', item.duration),
//               // const SizedBox(height: 12),
//               // kv('Teacher', item.instructor),
//               // const SizedBox(height: 12),
//               // kv('Paid', item.isPaid ? 'Yes' : 'No'),
        
//               buildSizeBox(20.0, 0.0),
//               BuildText.buildText(text: "Targeted",fontFamily: FontFamily.semiBold),
//               buildSizeBox(10.0, 0.0),
//               Wrap(
//                 spacing: 6,
//                 runSpacing: -8,
//                 children: item.targets
//                     .map((c) => MyBatchesChip(label: c, color: AppColors.primaryColor))
//                     .toList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
  

// }
 