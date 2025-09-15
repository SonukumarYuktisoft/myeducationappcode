import 'package:education/core/constants/color.dart';
import 'package:education/core/constants/font_family.dart';
import 'package:education/core/constants/font_style.dart';
import 'package:education/controller/chat/support_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportChatScreen extends StatelessWidget {
  const SupportChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(SupportController());

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: _buildAppBar(controller),
      body: Column(
        children: [
          Expanded(
            child: _buildMessagesList(controller),
          ),
          _buildMessageInput(controller),
        ],
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  PreferredSizeWidget _buildAppBar(SupportController controller) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.blackColor,
        ),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            child: Icon(
              Icons.support_agent,
              color: AppColors.primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customer Support',
                  style: TextStyleCustom.normalStyle(
                    fontSize: 16,
                    color: AppColors.blackColor,
                    fontFamily: FontFamily.semiBold,
                  ),
                ),
                Text(
                  'We\'re here to help',
                  style: TextStyleCustom.normalStyle(
                    fontSize: 12,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_vert,
            color: AppColors.blackColor,
          ),
        ),
      ],
    );
  }

  Widget _buildMessagesList(SupportController controller) {
    return Obx(() => ListView.builder(
      controller: controller.scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: controller.messages.length,
      itemBuilder: (context, index) {
        final message = controller.messages[index];
        return _buildMessageBubble(message, controller);
      },
    ));
  }

  Widget _buildMessageBubble(SupportMessage message, SupportController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isFromSupport ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (message.isFromSupport) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: Icon(
                Icons.support_agent,
                color: AppColors.primaryColor,
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: Get.size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isFromSupport 
                    ? AppColors.clrD6D6D6.withOpacity(0.3)
                    : AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(message.isFromSupport ? 4 : 20),
                  bottomRight: Radius.circular(message.isFromSupport ? 20 : 4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyleCustom.normalStyle(
                      fontSize: 14,
                      color: message.isFromSupport ? AppColors.blackColor : AppColors.whiteColor,
                    ),
                  ),
                  if (message.options != null) ...[
                    const SizedBox(height: 12),
                    _buildOptionsList(message.options!, controller),
                  ],
                  const SizedBox(height: 4),
                  Text(
                    controller.formatTime(message.timestamp),
                    style: TextStyleCustom.normalStyle(
                      fontSize: 11,
                      color: message.isFromSupport 
                          ? AppColors.clr606060
                          : AppColors.whiteColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!message.isFromSupport) ...[
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

  Widget _buildOptionsList(List<String> options, SupportController controller) {
    return Column(
      children: options.map((option) => _buildOptionButton(option, controller)).toList(),
    );
  }

  Widget _buildOptionButton(String option, SupportController controller) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        onPressed: () => controller.selectOption(option),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
          foregroundColor: AppColors.primaryColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: AppColors.primaryColor.withOpacity(0.3),
            ),
          ),
        ),
        child: Text(
          option,
          style: TextStyleCustom.normalStyle(
            fontSize: 13,
            color: AppColors.primaryColor,
            fontFamily: FontFamily.medium,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget _buildMessageInput(SupportController controller) {
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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.clrD6D6D6.withOpacity(0.3),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: controller.messageController,
                decoration: InputDecoration(
                  hintText: 'Type your message...',
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
              child: Icon(
                Icons.send,
                color: AppColors.whiteColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
