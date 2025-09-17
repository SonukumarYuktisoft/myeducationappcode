import 'package:flutter/material.dart';

class RecordedVideosScreen extends StatefulWidget {
  const RecordedVideosScreen({super.key});

  @override
  State<RecordedVideosScreen> createState() => _RecordedVideosScreenState();
}

class _RecordedVideosScreenState extends State<RecordedVideosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Center(child: Text('Recorded Videos Screen')));
  }
}
