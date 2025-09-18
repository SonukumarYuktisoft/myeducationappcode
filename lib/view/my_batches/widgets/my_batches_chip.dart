import 'package:education/core/constants/color.dart';
import 'package:education/core/constants/font_family.dart';
import 'package:education/core/constants/font_style.dart';
import 'package:flutter/material.dart';

class MyBatchesChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  
  const MyBatchesChip({
    super.key, 
    required this.label, 
    required this.color,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? color : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyleCustom.normalStyle(
          fontSize: 11,
          color: isSelected ? AppColors.whiteColor : color,
          fontFamily: FontFamily.semiBold,
        ),
      ),
    );
  }
}