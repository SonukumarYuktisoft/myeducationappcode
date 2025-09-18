import 'package:education/view/aI_assistant/chat_controller.dart';
import 'package:education/view/aI_assistant/gemini_service.dart';
import 'package:education/view/aI_assistant/widgets/message_bubble.dart';
import 'package:education/view/aI_assistant/widgets/typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AiAssistantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Register GeminiService first (it's a dependency of ChatController)
    Get.put(GeminiService());
    final ChatController controller = Get.put(ChatController());

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue.shade100,
              child: Icon(Icons.smart_toy, color: Colors.blue),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Gemini AI', style: TextStyle(fontSize: 18)),
                Text('Online', 
                     style: TextStyle(fontSize: 12, color: Colors.green)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: Text('Clear Chat'),
                  content: Text('Are you sure you want to clear all messages?'),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.clearChat();
                        Get.back();
                      },
                      child: Text('Clear'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.messages.length + 
                           (controller.isTyping.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == controller.messages.length) {
                    return TypingIndicator();
                  }
                  return MessageBubble(message: controller.messages[index]);
                },
              )),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: controller.messageController,
                        maxLines: null,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => controller.sendMessage(),
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Obx(() => GestureDetector(
                    onTap: controller.isTyping.value 
                        ? null 
                        : controller.sendMessage,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: controller.isTyping.value 
                            ? Colors.grey 
                            : Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}