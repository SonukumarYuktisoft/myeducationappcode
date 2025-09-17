import 'package:flutter/material.dart';

class UpcomingBatchesScreen extends StatefulWidget {
  const UpcomingBatchesScreen({super.key});

  @override
  State<UpcomingBatchesScreen> createState() => _UpcomingBatchesScreenState();
}

class _UpcomingBatchesScreenState extends State<UpcomingBatchesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Center(child: Text('Upcoming Batches Screen')));
  }
}