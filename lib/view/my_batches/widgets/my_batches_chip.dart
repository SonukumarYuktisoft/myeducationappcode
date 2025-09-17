import 'package:education/core/constants/font_family.dart';
import 'package:education/core/constants/font_style.dart';
import 'package:flutter/widgets.dart';

class MyBatchesChip extends StatelessWidget {
  final String label;
  final Color color;
  const MyBatchesChip({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyleCustom.normalStyle(
          fontSize: 11,
          color: color,
          fontFamily: FontFamily.semiBold,
        ),
      ),
    );
  }
}