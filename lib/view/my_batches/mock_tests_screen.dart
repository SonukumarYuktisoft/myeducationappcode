import 'package:flutter/material.dart';

class MockTestsScreen extends StatefulWidget {
  const MockTestsScreen({super.key});

  @override
  State<MockTestsScreen> createState() => _MockTestsScreenState();
}

class _MockTestsScreenState extends State<MockTestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Center(child: Text('Mock Tests Screen')));
  }
}