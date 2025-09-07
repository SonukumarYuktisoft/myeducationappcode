
import 'package:education/core/utils/print_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController{
  final Rx<XFile>  _image = XFile("").obs;
  Rx<XFile>  profileImage = XFile("").obs;
  Rx<XFile>  rxImage = XFile("").obs;
  Rx<XFile>  documentImage = XFile("").obs;
  RxBool isLoading = false.obs;
  Rx<XFile> image1 = XFile("").obs;

  final Rx<ImagePicker> _picker = ImagePicker().obs;
  RxList<XFile> imageList = <XFile>[].obs;

  Future<void> getImage( {required String source, required BuildContext context, required String type}) async {
    isLoading.value = true;
    try {
      if(source == "Camera"){
        _image.value = XFile("");
        _image.value = await _picker.value.pickImage(source: ImageSource.camera, imageQuality: 25) ?? XFile("");
        // if(_image != null){
        //   images.add(_image!.path);
        // }
      }else if(source == "Gallery"){
        _image.value = XFile("");
        _image.value = await _picker.value.pickImage(source: ImageSource.gallery, imageQuality: 25) ?? XFile("");
        // if(_image != null){
        //   images.add(_image!.path);
        // }
      }
      if(type == "profileImage"){
        profileImage.value = _image.value;
        isLoading.value = false;
      }
      if(type == "documentImage") {
        documentImage.value = _image.value;
        isLoading.value = false;
      }

    }catch(e){
      PrintLog.printLog("Exception: $e");
      isLoading.value = false;
    }
    update();
  }

  Future<void> getMultiImage() async {
    isLoading.value = true;
    try {
      imageList.value = [];
      imageList.value = await _picker.value.pickMultiImage( imageQuality: 25);
      isLoading.value = false;
    }catch(e){
      PrintLog.printLog("Exception: $e");
      isLoading.value = false;
    }
    update();
  }


  void updateProfileImage(XFile image){
    profileImage.value = image;
    PrintLog.printLog("profileImage $profileImage");
    update();
  }
  void updatePhoto(XFile image){
    image1.value = image;
    PrintLog.printLog("profileImage $profileImage");
    update();
  }

  void updateDocumentImage(XFile image){
    documentImage.value = image;
    PrintLog.printLog("profileImage $documentImage");
    update();
  }
}