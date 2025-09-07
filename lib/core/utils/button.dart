

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../constants/color.dart';
import '../constants/font_family.dart';

class BtnCustom{
  static final BtnCustom _singleton = BtnCustom._internal();
  factory BtnCustom() {
    return _singleton;
  }
  BtnCustom._internal();

  static Widget mainButton({
    Color? btnColor,
    double? titleSize,
    Color? titleColor,
    double? width,
    double? height,
    double? borderRadius,
    BoxBorder? border,
    required String title,
    required VoidCallback onPress,
    bool? isLoading,
    bool? isButtonActive = true
  }){
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
      ),
      child: MaterialButton(
        animationDuration: Duration(milliseconds: 500),
        padding: EdgeInsets.zero,
        splashColor: AppColors.primaryColor,
        elevation: 0.0,
        height: height ?? 50.0,
        minWidth: width ?? Get.width,
        onPressed: isLoading == true || isButtonActive == false ? null : onPress,
        child: isLoading == true && Platform.isIOS ?
          CupertinoActivityIndicator(color: AppColors.whiteColor) :
          isLoading == true && Platform.isAndroid ?
          SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(color: AppColors.whiteColor,strokeWidth: 2.0,)
          ) :
          Transform(
            transform: Matrix4.skewX(-0.2),
            child: Text(title.tr.toUpperCase(), style: TextStyle(fontSize: titleSize ?? 18.0, fontFamily: FontFamily.regular,color: titleColor ?? AppColors.whiteColor),textAlign: TextAlign.center,))
      ),
    );
  }

  static Widget animatedButton({
    Color? btnColor,
    double? titleSize,
    Color? titleColor,
    double? width,
    double? height,
    double? borderRadius,
    BoxBorder? border,
    required String title,
    required VoidCallback onPress,
    bool? isLoading,
    bool? isButtonActive = false
  }){
    return Align(
      alignment: Alignment.center,
      child: AnimatedContainer(
        curve: Curves.linearToEaseOut,
        duration: Duration(milliseconds: 400),
        width: isLoading == true ?  60 : (width ?? Get.width),
        decoration: BoxDecoration(
          gradient: isButtonActive == true ? AppColors.linearButtonColor : AppColors.inActiveButtonGradientColor,
          borderRadius: BorderRadius.circular(isLoading == true ? 30 : 10)
        ),
        child: MaterialButton(
          animationDuration: Duration(milliseconds: 500),
          padding: EdgeInsets.zero,
          splashColor: AppColors.primaryColor,
          elevation: 0.0,
          height: height ?? 60.0,
          minWidth: width ?? Get.width,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius ??(isLoading == true ? 30 : 10.0)))),
          onPressed: isLoading == true || isButtonActive == false ? null : onPress,
          child: isLoading == true && Platform.isIOS ? 
            CupertinoActivityIndicator(color: AppColors.whiteColor) :
            isLoading == true && Platform.isAndroid ?
            SizedBox(
              height: 35,
              width: 35,
              child: CircularProgressIndicator(color: AppColors.whiteColor,strokeWidth: 3.0,strokeCap: StrokeCap.round,)
            ) :
            Text(title, style: TextStyle(fontSize: titleSize ?? 18.0, fontFamily: FontFamily.regular,color: titleColor ?? AppColors.whiteColor,),textAlign: TextAlign.center,)
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final Color? color;
  final Color? txtColor;
  final Function() onPressed;
  final String? text;
  final double? btnWidth;
  final double? borderRadius;
  final double? btnHeight;
  final double? txtSize;
  final TextStyle? textStyle;
  final Widget? child;
  final Color? borderColor;
  final double? borderWidth;
  final bool? isLoading;
  final bool? isGradient;

  const CustomButton({
    super.key,
    this.color,
    this.text,
    this.txtColor,
    this.borderRadius,
    this.borderColor,
    required this.onPressed,
    this.btnWidth,
    this.txtSize,
    this.btnHeight,
    this.textStyle,
    this.child,
    this.borderWidth,
    this.isLoading,
    this.isGradient = true,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  double _opacity = 1.0;
  bool _isPressed = false;
  bool _showText = false;

  @override
  void initState() {
    super.initState();
    if (widget.isLoading != true) {
      _showText = true;
    }
  }

  @override
  void didUpdateWidget(covariant CustomButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isLoading == true && widget.isLoading != true) {
      // Loading just ended — wait before showing text
      _showText = false;
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted) {
          setState(() {
            _showText = true;
          });
        }
      });
    }

    if (oldWidget.isLoading != true && widget.isLoading == true) {
      // Loading just started — hide text
      setState(() {
        _showText = false;
      });
    }
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.96; // Shrink effect
      _opacity = 0.8; // Fade effect
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) async {
    await Future.delayed(const Duration(milliseconds: 80)); // Wait for animation
    setState(() {
      _scale = 1.0;
      _opacity = 1.0;
    });
    HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 80));

    if (_isPressed) {
      widget.onPressed();
    }
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
      _opacity = 1.0;
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      heightFactor: 1,
      alignment: Alignment.center,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: Opacity(
          opacity: _opacity,
          child: AnimatedContainer(
            curve: Curves.linearToEaseOut,
            duration: Duration(milliseconds: 350),
            padding: EdgeInsets.symmetric(horizontal: 5),
            transform: Matrix4.identity()..scale(_scale),
            height: widget.btnHeight ?? 55.0,
            width: widget.isLoading == true ?  55 : (widget.btnWidth ?? Get.width),
            decoration: BoxDecoration(
              gradient: widget.isGradient == true ? AppColors.linearButtonColor : null,
              color: widget.color ?? AppColors.primaryColor,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? (widget.isLoading == true ? 100.0 : 15.0)),
              border: Border.all(
                color: widget.borderColor ?? Colors.transparent,
                width: widget.borderWidth ?? 1.5,
              ),
            ),
            child: widget.child ??
                Center(
                  child: widget.isLoading == true ?
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(color: AppColors.blackColor,strokeWidth: 2.5,strokeCap: StrokeCap.round)
                    ) :
                    _showText ?
                    Text(widget.text ?? "", style: widget.textStyle ?? TextStyle(fontSize: widget.txtSize ?? 18.0, fontFamily: FontFamily.medium,color: widget.txtColor ?? AppColors.whiteColor,),textAlign: TextAlign.center,) : const SizedBox(),
                ),
          ),
        ),
      ),
    );
  }
}