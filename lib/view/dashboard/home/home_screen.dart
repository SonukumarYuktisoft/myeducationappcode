import 'package:education/core/constants/color.dart';
import 'package:education/core/utils/text.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leadingWidth: 60,
        titleSpacing: 10.0,
        leading: Container(
          margin: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor
          ),

        ),
        title: const Text('Bihar Classes'),
      ),
      body: Center(
        child: BuildText.buildText(text: 'Home'),
      ),
    );
  }
}
