import 'package:education/core/constants/color.dart';
import 'package:education/core/constants/font_family.dart';
import 'package:education/core/constants/font_style.dart';
import 'package:education/controller/chat/conversation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversationScreen extends StatelessWidget {
  final String instructorName;
  final String subject;
  final bool isOnline;
  final String? image;
  final bool? isGroup;
  const ConversationScreen({
    super.key,
    required this.instructorName,
    required this.subject,
    required this.isOnline,
    required this.image,
    this.isGroup = true
  });

  @override
  Widget build(BuildContext context) {
    // Initialize controller with parameters
    final controller = Get.put(
      ConversationController(
        instructorName: instructorName,
        subject: subject,
        isOnline: isOnline,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: _buildAppBar(controller),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildMessagesList(controller)),
            _buildMessageInput(controller),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  PreferredSizeWidget _buildAppBar(ConversationController controller) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      leadingWidth: 95, // 👈 back + avatar ke liye extra width
      leading: Row(
        children: [
          const SizedBox(width: 5),
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios, color: AppColors.blackColor),
          ),
          Stack(
            children: [
              CircleAvatar(radius: 20, backgroundImage: AssetImage(image!)),
              if (controller.isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.whiteColor,
                        width: 2,
                      ), // 👈 WhatsApp-style border
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.instructorName,
            style: TextStyleCustom.normalStyle(
              fontSize: 14,
              color: AppColors.blackColor,
              fontFamily: FontFamily.semiBold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            controller.subject,
            style: TextStyleCustom.normalStyle(
              fontSize: 12,
              color: AppColors.primaryColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.videocam_outlined, color: AppColors.blackColor),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.call_outlined, color: AppColors.blackColor),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert, color: AppColors.blackColor),
        ),
      ],
    );
  }

  Widget _buildMessagesList(ConversationController controller) {
    return Obx(
      () => ListView.builder(
        controller: controller.scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: controller.messages.length,
        itemBuilder: (context, index) {
          final message = controller.messages[index];
          return _buildMessageBubble(message, controller);
        },
      ),
    );
  }

  Widget _buildMessageBubble(
    ChatMessage message,
    ConversationController controller,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage:isGroup! ?AssetImage(image!): NetworkImage(
                'https://i.pravatar.cc/150?u=${controller.instructorName}',
              ),
              // backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              // child: Text(
              //   controller.instructorName
              //       .split(' ')
              //       .map((e) => e[0])
              //       .take(2)
              //       .join(),
              //   style: TextStyleCustom.normalStyle(
              //     fontSize: 12,
              //     color: AppColors.primaryColor,
              //     fontFamily: FontFamily.semiBold,
              //   ),
              // ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: Get.size.width * 0.75),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color:
                    message.isMe
                        ? AppColors.primaryColor
                        : AppColors.clrD6D6D6.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(message.isMe ? 20 : 4),
                  bottomRight: Radius.circular(message.isMe ? 4 : 20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyleCustom.normalStyle(
                      fontSize: 14,
                      color:
                          message.isMe
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.formatTime(message.timestamp),
                    style: TextStyleCustom.normalStyle(
                      fontSize: 11,
                      color:
                          message.isMe
                              ? AppColors.whiteColor.withOpacity(0.7)
                              : AppColors.clr606060,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isMe) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: Text(
                'Me',
                style: TextStyleCustom.normalStyle(
                  fontSize: 10,
                  color: AppColors.primaryColor,
                  fontFamily: FontFamily.semiBold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput(ConversationController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.attach_file, color: AppColors.clr606060),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.clrD6D6D6.withOpacity(0.3),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: controller.messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyleCustom.normalStyle(
                    fontSize: 14,
                    color: AppColors.clr606060,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                maxLines: null,
                textInputAction: TextInputAction.send,
                onSubmitted: (value) => controller.sendMessage(),
                onTap: () {
                  // Scroll to bottom when keyboard opens
                  Future.delayed(const Duration(milliseconds: 300), () {
                    controller.scrollToBottom();
                  });
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: controller.sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.send, color: AppColors.whiteColor, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
