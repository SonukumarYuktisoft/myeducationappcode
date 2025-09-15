import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final RxList<SupportMessage> messages = <SupportMessage>[].obs;
  
  final RxString selectedCategory = "".obs;
  final RxString selectedSubCategory = "".obs;


  @override
  void onInit() {
    super.onInit();
    _loadInitialMessage();
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void _loadInitialMessage() {
    // Initial support message with options
    messages.add(
      SupportMessage(
        text: "Hello! I'm here to help you. Please select the category that best describes your issue:",
        isFromSupport: true,
        timestamp: DateTime.now(),
        options: [
          "Course Access Issues",
          "Payment & Billing",
          "Technical Problems",
          "General Inquiry"
        ],
      ),
    );
  }

  void selectOption(String option) {
    // Add user's selection as a message
    messages.add(
      SupportMessage(
        text: option,
        isFromSupport: false,
        timestamp: DateTime.now(),
      ),
    );

    // Process the selection and provide follow-up
    _processOptionSelection(option);
    scrollToBottom();
  }

  void _processOptionSelection(String option) {
  String response = "";
  List<String>? nextOptions;

  if (selectedCategory.value.isEmpty) {
    // First level selection
    selectedCategory.value = option;

    switch (option) {
      case "Course Access Issues":
        response = "I understand you're having trouble accessing your course. Please select the specific issue:";
        nextOptions = [
          "Can't login to my account",
          "Course not showing in dashboard",
          "Video not playing",
          "Download not working"
        ];
        break;
      case "Payment & Billing":
        response = "I'll help you with payment and billing issues. What's the problem?";
        nextOptions = [
          "Refund request",
          "Payment not processed",
          "Wrong amount charged",
          "Subscription renewal"
        ];
        break;
      case "Technical Problems":
        response = "Let me help you resolve the technical issue. What's happening?";
        nextOptions = [
          "App keeps crashing",
          "Slow loading/performance",
          "Can't upload files",
          "Audio/video sync issues"
        ];
        break;
      case "General Inquiry":
        response = "I'm here to answer your general questions. What would you like to know?";
        nextOptions = [
          "Course recommendations",
          "Account settings",
          "Privacy & security",
          "Other questions"
        ];
        break;
    }
  } else if (selectedSubCategory.value.isEmpty) {
    // Second level selection
    selectedSubCategory.value = option;

    switch (selectedCategory.value) {
      case "Course Access Issues":
        response = "I've noted your issue: $option. Our technical team will look into this and get back to you within 24 hours. Is there anything else I can help you with?";
        break;
      case "Payment & Billing":
        response = "I understand your concern about: $option. I'll escalate this to our billing department. You should receive an email confirmation shortly. Do you need immediate assistance?";
        break;
      case "Technical Problems":
        response = "I've logged your technical issue: $option. Our support team will investigate and provide a solution. In the meantime, try restarting the app. Any other issues?";
        break;
      case "General Inquiry":
        response = "Thank you for your inquiry about: $option. I'd be happy to provide more information. What specific details would you like to know?";
        break;
    }
  }

  // Add support response
  messages.add(
    SupportMessage(
      text: response,
      isFromSupport: true,
      timestamp: DateTime.now(),
      options: nextOptions,
    ),
  );

  scrollToBottom();
}

void sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      messages.add(
        SupportMessage(
          text: messageController.text.trim(),
          isFromSupport: false,
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

class SupportMessage {
  final String text;
  final bool isFromSupport;
  final DateTime timestamp;
  final List<String>? options;

  SupportMessage({
    required this.text,
    required this.isFromSupport,
    required this.timestamp,
    this.options,
  });
}
