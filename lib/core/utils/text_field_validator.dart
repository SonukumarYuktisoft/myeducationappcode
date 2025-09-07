
import 'package:flutter/material.dart';

class TxtValidation{
  static final TxtValidation _singleton = TxtValidation._internal();
  factory TxtValidation() {
    return _singleton;
  }
  TxtValidation._internal();

  static emptyTextField(TextEditingController controller){
    if(controller.text.toString().trim().isEmpty) {
      return true;
    }
    return false;
  }

  static userNameTextField(TextEditingController controller){
    if(controller.text.toString().trim().isNotEmpty && controller.text.toString().trim().length < 3) {
      return true;
    }
    RegExp regex = RegExp(r"^[a-zA-Z]+$");
    if (!regex.hasMatch(controller.text.toString().trim())) return true;
    return false;
  }

  static numberTextField(TextEditingController controller){
    if(controller.text.toString().trim().isEmpty) {
      return true;
    }
    RegExp regex = RegExp(r"^\d+$");
    if (!regex.hasMatch(controller.text.toString().trim())) return true;
    return false;
  }
  
  static dobValidate(TextEditingController controller){
    if(controller.text.toString().trim().isEmpty) {
      return true;
    }
    RegExp regex = RegExp(r'^(3[01]|[12][0-9]|0?[1-9])(\/|-)(1[0-2]|0?[1-9])\2([0-9]{2})?[0-9]{4}$');
    if (!regex.hasMatch(controller.text.toString().trim())) return true;
    return false;
  }

  static userPasswordTextField(TextEditingController controller){
    if(controller.text.toString().trim().isNotEmpty && controller.text.toString().trim().length < 5) {
      return true;
    }
    return false;
  }
  static passwordMatchTextField(TextEditingController controller,TextEditingController controller2){
    if(controller.text.toString().trim() == controller2.text.toString().trim()) {
      return false;
    }
    return true;
  }

  static confirmPasswordMatchTextField(TextEditingController controller,TextEditingController controller2){
    if(controller.text.toString() != controller2.text.toString()) {
      return true;
    }
    return false;
  }

  static validatePasswordTextField(TextEditingController controller) {
    if (controller.text.toString().trim().isEmpty) return true;
    RegExp regex = RegExp(r'^(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).*$');
    // RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#&*~]).{8,32}$');
    if (!regex.hasMatch(controller.text.toString().trim())) return true;
    return false;
  }

  // static validatePasswordTextFieldNew(TextEditingController controller) {
  //   if (controller.text.toString().trim().isEmpty) return null;
  //   RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#&*~]).{8,32}$');
  //   if (!regex.hasMatch(controller.text.toString().trim())) return AppString.kEnterValidChangeNewPassword;
  //   return null;
  // }

  static validateMobileTextField(TextEditingController controller){
    if (controller.text.toString().trim().isEmpty) return true;
    // RegExp regex = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    // if (!regex.hasMatch(controller.text.toString().trim())) return true;
    if(controller.text.toString().trim().isNotEmpty && controller.text.toString().trim().length < 12) {
      return true;
    }
    return false;
  }

  static validateEmailTextField(TextEditingController controller){
    if(controller.text.toString().trim().isEmpty) {
      return true;
    }
    // RegExp regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    // if (!regex.hasMatch(controller.text.toString().trim())) {
    //   return true;
    // }
    return false;
  }

  static validateEmailTextFieldNew(TextEditingController controller) {
    if (controller.text.toString().trim().isEmpty) return null;
    RegExp regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regex.hasMatch(controller.text.toString().trim())) return "Enter Valid Email Id";
    return null;
  }










  static validateAadhaarTextField(TextEditingController controller){
    if(controller.text.toString().trim().isNotEmpty && controller.text.toString().trim().length < 12) {
      return true;
    }
    return false;
  }

  static validateMPinTextField(TextEditingController controller){
    if(controller.text.toString().trim().isNotEmpty && controller.text.toString().trim().length < 4) {
      return true;
    }
    return false;
  }

  static validatePinTextField(TextEditingController controller){
    if(controller.text.toString().trim().isNotEmpty && controller.text.toString().trim().length < 4) {
      return true;
    }
    return false;
  }

  static validateEmployeeId(TextEditingController controller){
    if(controller.text.toString().trim().isNotEmpty && controller.text.toString().trim().length < 12) {
      return true;
    }
    return false;
  }



}