
import 'dart:io';
import 'package:education/core/utils/bottomsheet_custom.dart';
import 'package:education/core/utils/image_picker_controller.dart';
import 'package:education/core/utils/permission_handler/permission_controller.dart';
import 'package:education/core/utils/print_log.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatWithAiController extends GetxController with GetSingleTickerProviderStateMixin{

  AnimationController? animationController;
  Animation<int>? characterCountAnimation;

  Rx<TextEditingController> textController = TextEditingController().obs;
  Gemini? gemini;
  RxList<ChatResponseModel> chatList = <ChatResponseModel>[].obs;
  Rx<ScrollController> scrollController = ScrollController().obs;

  ImagePickerController? imagePickerCtrl = Get.put(ImagePickerController());
  PermissionController permissionController = Get.put(PermissionController());

  RxBool isLoading = false.obs;
  RxInt idCount = 1.obs;
  Rx<FilePickerResult> filePickerResult = const FilePickerResult([]).obs;
  String? selectedDocumentForShare;

  RxDouble addedImageHeight = 0.0.obs;
  RxBool isGestureDetected = true.obs;

  @override
  void onInit() {
    super.onInit();
    gemini = Gemini.instance;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    characterCountAnimation = IntTween(begin: 0, end: 0).animate(animationController!);
    initCalling();
  }

  @override
  void onClose() {
    animationController?.dispose();
    textController.value.dispose();
    scrollController.value.dispose();
    super.onClose();
  }

  Future<void> initCalling()async{
    gemini?.streamGenerateContent('Utilizing Google Ads in Flutter')
    .listen((value) {
      PrintLog.printLog("Response : ${value.output}");
    }).onError((e) {
      PrintLog.printLog('streamGenerateContent Exception : $e');
    });
  }
  
  Future<void> onTapSend(context)async{
    if(FocusScope.of(context).hasFocus){
      FocusScope.of(context).unfocus();
    }
    String selectedImage = imagePickerCtrl?.profileImage.value.path ?? "";
    if(imagePickerCtrl?.profileImage.value.path == null || imagePickerCtrl?.profileImage.value.path == ""){
      chatList.add(ChatResponseModel(id: 0,response: textController.value.text.toString(),image: ""));
      imagePickerCtrl?.profileImage.value = XFile("");
      addedImageHeight.value = 0.0;
    }else{
      chatList.add(ChatResponseModel(id: 0,response: textController.value.text.toString(),image: imagePickerCtrl?.profileImage.value.path));
      imagePickerCtrl?.profileImage.value = XFile("");
      addedImageHeight.value = 0.0;
    }
    Future.delayed(const Duration(milliseconds: 100),(){
        automaticScrollDown();
      });
    try{
      changeLoadingvalue(true);
      
      if(selectedImage == "null" || selectedImage == ""){
        await gemini?.text(textController.value.text.toString()).then((value) {
          if(value != null && value.output!.length < 50) {
            animationController?.duration = Duration(milliseconds: value.output!.length * 70);
          }else if(value != null && value.output!.length < 100){
            animationController?.duration = Duration(milliseconds: value.output!.length * 50);
          }else if(value != null && value.output!.length < 150){
            animationController?.duration = Duration(milliseconds: value.output!.length * 30);
          }else{
            animationController?.duration = Duration(milliseconds: value != null ? value.output!.length * 8 : 0);
          }
          characterCountAnimation = IntTween(begin: 0, end: value?.output?.length ?? 0).animate(animationController!);
          animationController?.forward(from: 0);
          idCount++;
          chatList.add(ChatResponseModel(id: idCount.value,response: value?.output ?? "",image: ""));
          PrintLog.printLog(value?.output);
        });
      }else{
        await gemini?.textAndImage(text:textController.value.text.toString(),images: [File(selectedImage).readAsBytesSync()])
        .then((value) {
          if(value!.output!.length < 50) {
            animationController?.duration = Duration(milliseconds: value.output!.length * 70);
          }else if(value.output!.length < 100){
            animationController?.duration = Duration(milliseconds: value.output!.length * 50);
          }else if(value.output!.length < 150){
            animationController?.duration = Duration(milliseconds: value.output!.length * 30);
          }else{
            animationController?.duration = Duration(milliseconds: value.output!.length * 8);
          }
          characterCountAnimation = IntTween(begin: 0, end: value.output?.length ?? 0).animate(animationController!);
          animationController?.forward(from: 0);
          idCount++;
          chatList.add(ChatResponseModel(id: idCount.value,response: value.output ?? "",image: imagePickerCtrl?.profileImage.value.path));
          PrintLog.printLog(value.output);
        });
      }
      changeLoadingvalue(false);
      Future.delayed(const Duration(milliseconds: 200),(){
        automaticScrollDown();
      });
    textController.value.clear();
    }catch(e){
      changeLoadingvalue(false);
      PrintLog.printLog('Exception : $e');
    }
  }

  automaticScrollDown(){
    if(scrollController.value.hasClients && scrollController.value.offset != scrollController.value.position.maxScrollExtent){
      scrollController.value.animateTo(scrollController.value.position.maxScrollExtent, duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
    }
  }

  onTapAttachment(){
     BottomSheetCustom.showShareAttachmentBottomSheet(
      context: Get.overlayContext!, 
      onValue: (value){
        if(value == "photo"){
          showImagePickerOption();
        }else if(value == "document"){
          selectDocument();
        }
        PrintLog.printLog("Share Option : $value");
      }
    );
  }

  showImagePickerOption(){
    BottomSheetCustom.showImagePickerBottomSheet(
      context: Get.overlayContext!, 
      onValue: (value){
        if(value.toString().toLowerCase() == "gallery"){
          getImage("Gallery");
        }else if(value.toString().toLowerCase() == "camera"){
          getImage("Camera");
        }
      }
    );
  }

  selectDocument()async{
    filePickerResult.value = await FilePicker.platform.pickFiles(allowMultiple: false) ?? const FilePickerResult([]);
    if (filePickerResult.value.files[0].path == null || filePickerResult.value.files[0].path == "") {
      PrintLog.printLog("No file selected");
    } else {
      PrintLog.printLog("Selected Document : ${filePickerResult.value.files.toList()}");
      
      update();
    }
  }

  void getImage(source)async{
    // await permissionController.onTapCamera(context: Get.overlayContext!).then((value){
      // if(value == true){
        
        // if(!permissionController.isCamera){
        //   return;
        // }
        await imagePickerCtrl?.getImage(source:source,context: Get.overlayContext!,type: "profileImage").then((value) async{
          if(imagePickerCtrl?.profileImage != null){
            Future.delayed(const Duration(milliseconds: 350),(){
              addedImageHeight.value = 100.0;
            });
            // chatList.add(ChatResponseModel(id: 0,response: textController.value.text.toString(),image: imagePickerCtrl?.profileImage.value.path));
            // onTapSend(Get.context!,"image");
          }
          update();
        });
        // await permissionController.onTapCamera();
      // }
    // });
  }

  onTapRemoveImage(){
    if(imagePickerCtrl?.profileImage.value.path != null && imagePickerCtrl?.profileImage.value.path != ""){
      imagePickerCtrl?.profileImage.value = XFile("");
      addedImageHeight.value = 0.0;
    }
  }

  changeLoadingvalue(value){
    isLoading.value = value;
  }

  onTapReset(){
    chatList.clear();
  }
}


class ChatResponseModel{
  int? id;
  String? response;
  String? image;

  ChatResponseModel({required this.id,required this.response,required this.image});
}