
import 'dart:io';
import 'dart:math';

import 'package:education/controller/chat/chat_with_ai_controller.dart';
import 'package:education/core/constants/color.dart';
import 'package:education/core/utils/animation/animation.dart';
import 'package:education/core/utils/text.dart';
import 'package:education/core/utils/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatWithAiScreen extends StatefulWidget {
  const ChatWithAiScreen({super.key});

  @override
  State<ChatWithAiScreen> createState() => _ChatWithAiScreenState();
}

class _ChatWithAiScreenState extends State<ChatWithAiScreen> {

  late ChatWithAiController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ChatWithAiController());
  }

  @override
  void dispose() {
    Get.delete<ChatWithAiController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: (details) {
        controller.isGestureDetected.value = false;
      },
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container(
              //   height: 25,
              //   width: 25,
              //   margin: const EdgeInsets.all(10),
              //   clipBehavior: Clip.antiAlias,
              //   decoration: const BoxDecoration(
              //     shape: BoxShape.circle
              //   ),
              //   child: SvgPicture.asset("assets/svg/google-gemini-icon.svg"),
              // ),
              BuildText.buildText(text: "Gemini AI",color: Colors.white,weight: FontWeight.w600,size: 18),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => controller.onTapReset(), 
              child: BuildText.buildText(text: "Reset",color: AppColors.whiteColor,weight: FontWeight.w500)
            )
          ],
        ),
        // bottomNavigationBar: 
        body: Obx((){
          return 
            Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                controller.chatList.isNotEmpty ?
                Expanded(
                  child: ListView.builder(
                    reverse: false,
                    itemCount: controller.chatList.length,
                    shrinkWrap: false,
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    controller: controller.scrollController.value,
                    padding: const EdgeInsets.only(bottom: 0,top: 20),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      // controller.senderImage = controller.chatList?[index].senderId?.image ?? "" ;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20,left: 10,right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Visibility(
                            //   visible: controller.chatList[index].id != null && controller.chatList[index].id != 0,
                            //   child: Container(
                            //     height: 25,
                            //     width: 25,
                            //     margin: const EdgeInsets.only(top: 5),
                            //     clipBehavior: Clip.antiAlias,
                            //     decoration: const BoxDecoration(
                            //       shape: BoxShape.circle
                            //     ),
                            //     child: SvgPicture.asset("assets/svg/google-gemini-icon.svg"),
                            //   ),
                            // ),
                            buildSizeBox(0.0, 8.0),
                            (controller.chatList[index].id == null || controller.chatList[index].id == 0) ? const Spacer() : const SizedBox.shrink(),
      
                            controller.chatList[index].image == null ||  controller.chatList[index].image == "" ?
                            Expanded(
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.only(right: (controller.chatList[index].id != null && controller.chatList[index].id != 0) ? 60:0),
                                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (controller.chatList[index].id == null || controller.chatList[index].id == 0) ? Colors.blueAccent : Colors.transparent,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withValues(alpha: 0.2),
                                      blurRadius: 1,
                                      offset: const Offset(0, 1)
                                    )
                                  ]
                                ),
                                child: 
                                index == controller.chatList.length-1 && controller.chatList.length == 1 ?
                                BuildText.buildText(
                                  text: controller.chatList[index].response ?? "",
                                  color: Colors.white,
                                  weight: FontWeight.w500
                                ) :
                                index == controller.chatList.length-1 ?
                                AnimatedBuilder(
                                  animation: controller.characterCountAnimation ?? const AlwaysStoppedAnimation(0),
                                  builder: (context,child){
                                    String visibleText = controller.chatList[index].response?.substring(0, min(controller.chatList[index].response?.length ?? 0, controller.characterCountAnimation?.value ?? 0)) ?? "";
                                    if(controller.chatList.isNotEmpty && controller.chatList.length > 1 && controller.scrollController.value.offset == controller.scrollController.value.position.maxScrollExtent){
                                      controller.isGestureDetected.value = true;
                                    }
                                    if(controller.isGestureDetected.value) {
                                      controller.automaticScrollDown();
                                    }
                                    return BuildText.buildText(
                                      text: visibleText,
                                      color: Colors.white,
                                      weight: FontWeight.w500
                                    );
                                  },
                                ) : BuildText.buildText(
                                  text: controller.chatList[index].response ?? "",
                                  color: Colors.white,
                                  weight: FontWeight.w500
                                )
                                
                                
                              ).fadeAnimation(0.01,animationDirectionDown: true),
                            ) : imageWidget(index),
                          ],
                        ),
                      );
                    },
                  ),
                ): 
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 300),
                    child: BuildText.buildText(text: "What can I help with?",color: Colors.grey,weight: FontWeight.w600,size: 16),
                  ),
                ),
                // controller.isLoading.value ? buildSizeBox(0.0, 0.0) : const SizedBox.shrink(),
            
                Visibility(
                  visible: controller.isLoading.value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),

                // Visibility(
                //   visible: FocusScope.of(context).hasFocus,
                //   child: const SizedBox(height: 30,)),

                Obx((){
                  return Container(
                    margin: EdgeInsets.only(left: 10,right: 10,bottom: Platform.isIOS ? 25:10,top: 10),
                    color: Colors.black,
                    child: AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      height: (controller.imagePickerCtrl?.profileImage.value.path != null && controller.imagePickerCtrl?.profileImage.value.path != "") ? 180:70,
                      duration: const Duration(milliseconds: 650),
                      padding: EdgeInsets.all((controller.imagePickerCtrl?.profileImage.value.path != null && controller.imagePickerCtrl?.profileImage.value.path != "") ? 10:0),
                      decoration: BoxDecoration(
                        color: (controller.imagePickerCtrl?.profileImage.value.path != null && controller.imagePickerCtrl?.profileImage.value.path != "") ? Colors.grey.shade800 : Colors.transparent,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                            visible: (controller.imagePickerCtrl?.profileImage.value.path != null && controller.imagePickerCtrl?.profileImage.value.path != ""),
                            child: Stack(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 0),
                                  height: controller.addedImageHeight.value,
                                  width: 100,
                                  // margin: EdgeInsets.only(bottom: (controller.imagePickerCtrl?.profileImage.value.path != null && controller.imagePickerCtrl?.profileImage.value.path != "") ? 10 : 0),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Image.file(File(controller.imagePickerCtrl?.profileImage.value.path ?? ""),fit: BoxFit.cover)
                                ),
                            
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Transform.translate(
                                    offset: const Offset(6, -6),
                                    child: GestureDetector(
                                      onTap: () => controller.onTapRemoveImage(),
                                      child: const Icon(Icons.cancel))),
                                )
                              ],
                            ),
                          ),
                          TextFieldCustom(
                            ontap: () {
                              Future.delayed(const Duration(milliseconds: 300),(){
                                controller.automaticScrollDown();
                              });
                            },
                            controller: controller.textController.value,
                            fillColor: Colors.grey.shade500,
                            hintText: "Message Gemini",
                            outlineBorderColor: Colors.transparent,
                            focusedBorderColor: Colors.transparent,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                if(controller.textController.value.text.isNotEmpty || (controller.imagePickerCtrl?.profileImage.value.path != null && controller.imagePickerCtrl?.profileImage.value.path != "")){
                                  controller.onTapSend(context);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.only(right: 5),
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle
                                ),
                                child: const Icon(Icons.send,color: Colors.white70)),
                            ),
                            prefix: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () => controller.onTapAttachment(),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                child: Icon(Icons.attachment_rounded,color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            );
        })
      ),
    );
  }

  Widget imageWidget(index){
    return (controller.chatList[index].id == null || controller.chatList[index].id == 0) ?
    Container(
      width: Get.size.aspectRatio * Get.width  * 1.2,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(20),topRight: Radius.circular(20))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 300,
            width: Get.size.aspectRatio * Get.width  * 1.2,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
            ),
            child: controller.chatList[index].image != null &&  controller.chatList[index].image != "" ?
            Image.file(File(controller.chatList[index].image ?? ""),fit: BoxFit.cover) : const SizedBox.shrink()
          ),
          Visibility(
            visible: controller.chatList[index].response != null && controller.chatList[index].response != "",
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: BuildText.buildText(
                text: controller.chatList[index].response ?? "",
                color: Colors.white,
                weight: FontWeight.w600,
                height: 1.7,
                textAlign: TextAlign.start
              ),
            ),
          )
        ],
      ),
    ) : 
    Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 40),
        child: BuildText.buildText(
          text: controller.chatList[index].response ?? "",
          color: Colors.white,
          weight: FontWeight.w600,
          height: 1.7,
          textAlign: TextAlign.start
        ),
      ),
    );
  }
}