import 'package:flutter/material.dart';
import 'fade_animation.dart';

extension WidgetExtension on Widget {
  Widget fadeAnimation(double delay,{bool? animationDirectionDown}) {
    return FadeInAnimation(delay: delay,animationDirectionDown: animationDirectionDown, child: this);
  }
}

// extension ColorExtension on String {
//   toColor() {
//     var hexString = this;
//     final buffer = StringBuffer();
//     if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
//     buffer.write(hexString.replaceFirst('#', ''));
//     return Color(int.parse(buffer.toString(), radix: 16));
//   }
// }