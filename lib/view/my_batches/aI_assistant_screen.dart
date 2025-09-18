import 'package:flutter/material.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<AiAssistantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Center(child: Text('Notes Screen')));
  }
}
