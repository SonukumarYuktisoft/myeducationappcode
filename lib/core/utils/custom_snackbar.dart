import 'package:education/core/utils/text.dart';
import 'package:flutter/material.dart';
import '../constants/font_family.dart';

class FadeSnackBar {
  static void show(BuildContext context, String message) {
    final overlay = Overlay.of(context);

    final entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: 20,
          left: 50,
          right: 50,
          child: Material(
            color: Colors.transparent,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 300),
              builder: (context, value, child) {
                return Opacity(opacity: value, child: child);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: BuildText.buildText(
                  text: message,
                  style: TextStyle(color: Colors.white, fontSize: 14,fontFamily: FontFamily.medium),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(entry);

    // Auto remove after 2 sec
    Future.delayed(const Duration(seconds: 2), () {
      entry.remove();
    });
  }
}