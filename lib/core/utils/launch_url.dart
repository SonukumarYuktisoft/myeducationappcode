//
// import 'dart:io';
// import 'package:rider_rescue/controller/utils/widget_controller/toast.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class LaunchUrlCustom{
//
//
//   static Future<void> launchPhone({required String phoneNumber})async{
//     final call = Uri.parse('tel: $phoneNumber');
//       if (await canLaunchUrl(call)) {
//         launchUrl(call);
//       } else {
//         throw 'Could not launch $call';
//       }
//   }
//
//   static Future<void> launchSMS({required String phoneNumber, String? message}) async {
//     try {
//       if (Platform.isAndroid) {
//         String uri = 'sms:$phoneNumber?body=${Uri.encodeComponent(message ?? "")}';
//         await launchUrl(Uri.parse(uri));
//       } else if (Platform.isIOS) {
//         String uri = 'sms:$phoneNumber&body=${Uri.encodeComponent(message ?? "")}';
//         await launchUrl(Uri.parse(uri));
//       }
//     } catch (e) {
//       ToastCustom.showSnackBar(subtitle: "Some error occurred. Please try again!");
//     }
//   }
//
//   static Future<void> redirectToBrowser(String url) async {
//     var link = url;
//     if (await canLaunchUrl(Uri.parse(link))) {
//       await launchUrl(Uri.parse(link),mode: LaunchMode.externalApplication);
//     } else {
//       ToastCustom.showSnackBar(subtitle: "Some error occurred. Please try again!");
//       throw 'Could not launch $link';
//     }
//   }
// }