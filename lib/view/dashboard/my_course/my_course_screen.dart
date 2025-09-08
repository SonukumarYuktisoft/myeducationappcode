import 'package:education/core/utils/text.dart';
import 'package:flutter/material.dart';

class MyCourseScreen extends StatelessWidget {
  const MyCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BuildText.buildText(text: 'My Course'),
      ),
    );
  }
}
