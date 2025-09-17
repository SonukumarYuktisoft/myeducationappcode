import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversationController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;

  final String instructorName;
  final String subject;
  final bool isOnline;

  final List<String> dummyReplies = [
    "Okay, noted 👍",
    "Great question! Let’s discuss further.",
    "I’ll explain that in more detail.",
    "Good point, keep it up!",
    "Yes, exactly.",
    "Hmm, interesting thought 🤔",
  ];

  ConversationController({
    required this.instructorName,
    required this.subject,
    required this.isOnline,
  });

  @override
  void onInit() {
    super.onInit();
    _loadSampleMessages();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void _loadSampleMessages() {
    messages.addAll([
      ChatMessage(
        text: "Hello! Let's start with some key points for UPSC prep.",
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ]);
  }

  void sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      // User message add
      messages.add(
        ChatMessage(
          text: messageController.text.trim(),
          isMe: true,
          timestamp: DateTime.now(),
        ),
      );
      messageController.clear();
      scrollToBottom();

      // 1 second delay -> auto reply
      Future.delayed(const Duration(seconds: 1), () {
        final random = Random();
        final reply = dummyReplies[random.nextInt(dummyReplies.length)];

        messages.add(
          ChatMessage(
            text: reply,
            isMe: false,
            timestamp: DateTime.now(),
          ),
        );
        scrollToBottom();
      });
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });
  }

  String formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.timestamp,
  });
}
