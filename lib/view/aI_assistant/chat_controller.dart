import 'package:education/view/aI_assistant/gemini_service.dart';
import 'package:education/view/aI_assistant/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class ChatController extends GetxController {
  final GeminiService _geminiService = Get.find<GeminiService>();
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final RxBool isTyping = false.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void sendMessage() async {
    final messageText = messageController.text.trim();
    if (messageText.isEmpty) return;

    // Clear input
    messageController.clear();

    // Add user message
    final userMessage = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: messageText,
      isUser: true,
      timestamp: DateTime.now(),
    );
    
    messages.add(userMessage);
    saveMessages();
    _scrollToBottom();

    // Show typing indicator
    isTyping.value = true;

    try {
      // Get AI response
      final aiResponse = await _geminiService.generateResponse(messageText);
      
      // Add AI message
      final aiMessage = MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: aiResponse,
        isUser: false,
        timestamp: DateTime.now(),
      );
      
      messages.add(aiMessage);
      saveMessages();
      
    } catch (e) {
      // Add error message
      final errorMessage = MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: 'Sorry, something went wrong. Please try again.',
        isUser: false,
        timestamp: DateTime.now(),
        status: MessageStatus.error,
      );
      messages.add(errorMessage);
      saveMessages();
    } finally {
      isTyping.value = false;
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void clearChat() {
    messages.clear();
    saveMessages();
  }

  Future<void> saveMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final messagesJson = messages.map((m) => m.toJson()).toList();
      await prefs.setString('chat_messages', jsonEncode(messagesJson));
    } catch (e) {
      print('Error saving messages: $e');
    }
  }

  Future<void> loadMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final messagesString = prefs.getString('chat_messages');
      if (messagesString != null) {
        final messagesList = jsonDecode(messagesString) as List;
        messages.value = messagesList
            .map((json) => MessageModel.fromJson(json))
            .toList();
      }
    } catch (e) {
      print('Error loading messages: $e');
    }
  }
}
