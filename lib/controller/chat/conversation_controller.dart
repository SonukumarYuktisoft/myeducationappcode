import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversationController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  
  final String instructorName;
  final String subject;
  final bool isOnline;

  ConversationController({
    required this.instructorName,
    required this.subject,
    required this.isOnline,
  });

  @override
  void onInit() {
    super.onInit();
    _loadSampleMessages();
    // Auto-scroll to bottom after the first frame is rendered
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
    // Sample messages for demonstration
    messages.addAll([
      ChatMessage(
        text: "Good morning! Today we will discuss the important topics for UPSC History.",
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      ChatMessage(
        text: "Good morning sir! I'm ready for the session.",
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
      ),
      ChatMessage(
        text: "Please make sure you have completed the previous chapter readings.",
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
      ),
      ChatMessage(
        text: "Yes sir, I have completed chapter 5 and 6. Should I also review chapter 4?",
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 15)),
      ),
      ChatMessage(
        text: "Yes, that would be helpful. Chapter 4 has some important concepts that connect with today's topic.",
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
    ]);
  }

  void sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      messages.add(
        ChatMessage(
          text: messageController.text.trim(),
          isMe: true,
          timestamp: DateTime.now(),
        ),
      );
      messageController.clear();
      scrollToBottom();
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        // Add a small delay to ensure the layout is updated
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
