import 'package:flutter/material.dart';

class FreeBatchesScreen extends StatefulWidget {
  const FreeBatchesScreen({super.key});

  @override
  State<FreeBatchesScreen> createState() => _FreeBatchesScreenState();
}

class _FreeBatchesScreenState extends State<FreeBatchesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Center(child: Text('Free Batches Screen')));
  }
}