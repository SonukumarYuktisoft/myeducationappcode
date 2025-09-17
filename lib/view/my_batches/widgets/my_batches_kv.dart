 import 'package:education/core/constants/color.dart';
import 'package:education/core/constants/font_family.dart';
import 'package:education/core/constants/font_style.dart';
import 'package:flutter/widgets.dart';

class MyBatchesKv extends StatelessWidget {
  final String label;
  final String value;
  const MyBatchesKv({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyleCustom.normalStyle(
              fontSize: 13,
              color: AppColors.clr606060,
              fontFamily: FontFamily.semiBold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyleCustom.normalStyle(
              fontSize: 13,
              color: AppColors.blackColor,
            ),
          ),
        ),
      ],
    );
  }
}