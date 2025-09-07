

import 'package:country_code_picker/country_code_picker.dart';
import 'package:education/core/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../constants/color.dart';
import '../constants/font_family.dart';

// ignore: must_be_immutable
class TextFieldCustom extends StatefulWidget{
  TextEditingController? controller;
  int? maxLength;
  TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  TextInputAction? textInputAction;
  bool? autofocus;
  InputDecoration? decoration;
  String? labelText;
  String? hintText;
  Color? fillColor;
  Color? outlineBorderColor;
  EdgeInsetsGeometry? contentPadding;
  double? borderRadius;
  InputBorder? enabledBorder;
  TextStyle? style;
  bool? isFloating;
  Widget? suffixIcon;
  bool? readOnly;
  Widget? prefix;
  Function(String)? onChanged;
  Function()? ontap;
  String?errorText;
  FocusNode? focusNode;
  bool? isPassword;
  int? maxLines;
  TextCapitalization? textCapitalization;
  Color? focusedBorderColor;
  final String? Function(String?)? validator;
  double? height;
  bool? isMandatory;
  bool? enabled;
  Color? hintColor;
  Color? cursorColor;

  TextFieldCustom({super.key,
    this.controller,
    this.maxLines,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.autofocus,
    this.decoration,
    this.labelText,
    this.hintText,
    this.fillColor,
    this.contentPadding,
    this.outlineBorderColor,
    this.borderRadius,
    this.enabledBorder,
    this.style,
    this.readOnly,
    this.suffixIcon,
    this.onChanged,
    this.prefix,
    this.ontap,
    this.errorText,
    this.focusNode,
    this.isPassword,
    this.textCapitalization,
    this.focusedBorderColor,
    this.validator,
    this.isFloating,
    this.height,
    this.isMandatory,
    this.enabled,
    this.hintColor,
    this.cursorColor
  });

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  bool? isFloating;
  bool eyeHide = false;

  @override
  void initState() {
    if(widget.isPassword == true){
      eyeHide = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          obscuringCharacter: "*",
          enabled: widget.enabled ?? true,
          validator: widget.validator,
          cursorHeight: 22.0,
          cursorColor: widget.cursorColor ?? AppColors.primaryColor,
          cursorWidth: 1.7,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          obscureText: eyeHide == true ? true:false,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          autofocus: widget.autofocus ?? false,
          readOnly: widget.readOnly ?? false,
          onTap: widget.ontap,
          maxLines:widget.maxLines ?? 1,
          focusNode: widget.focusNode,
          textCapitalization: widget.textCapitalization ?? TextCapitalization.sentences,
          onChanged: widget.onChanged ?? (value){},
          style: widget.style ?? TextStyle(color: AppColors.blackColor, fontFamily: FontFamily.regular,fontSize: 17,),
          decoration: widget.decoration ?? InputDecoration(
            isDense: true,
            hintStyle: TextStyle(color: widget.hintColor ?? AppColors.textFieldHintTextColor,fontFamily: FontFamily.medium,fontSize: 15),
            prefixIconConstraints: const BoxConstraints(maxHeight: 24,maxWidth: 60),
            label:
            widget.labelText !=null
           ?  RichText(text: TextSpan(
          style:  TextStyle(color: AppColors.blackColor,fontFamily: FontFamily.medium,fontSize: 14),
              children: [
                TextSpan(text: widget.labelText?.tr ?? '',style: TextStyle(color: AppColors.textFieldHintTextColor)),
            widget.isMandatory??false ?    TextSpan(text: " *",style: TextStyle(color: Colors.red,fontFamily: FontFamily.medium,fontSize: 16,fontWeight: FontWeight.bold),)
         : const TextSpan(text: "")  ]
            ),

            ):null,
            // labelText: widget.labelText ?? "",
            // labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: FontFamily.ralewayRegular,color: AppColors.greyLightTextColor.withOpacity(0.7)),
            fillColor: widget.fillColor ??  AppColors.textFieldBackgroundColor,
            hintText: widget.hintText ?? "",
            floatingLabelBehavior: FloatingLabelBehavior.never,
            filled: true,
            counterText: "",
            suffixIconConstraints: const BoxConstraints(minWidth: 50),
            suffixIcon: widget.isPassword == true ?
            InkWell(
              splashColor: Colors.transparent,
              onTap: (){
                setState(() {
                  eyeHide = !eyeHide;
                });
              },
              child: Icon(eyeHide == false ? Icons.remove_red_eye_outlined:Icons.visibility_off_outlined,color: Colors.grey.shade500,size: 22)) : widget.suffixIcon,
            prefixIcon: widget.prefix != null ? Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 8),
              child: widget.prefix) : const SizedBox(width: 15),
            contentPadding: widget.contentPadding ?? const EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 20),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(widget.borderRadius ?? 15.0),
            //   borderSide: BorderSide(color: widget.outlineBorderColor ?? AppColors.textFieldBackgroundColor),
            // ),
            // errorBorder: widget.errorText != null ? OutlineInputBorder(
            //   borderSide :  BorderSide(
            //     width: 1.2,
            //     color: AppColors.textFieldErrorBorderColor),
            //     borderRadius:const BorderRadius.all(Radius.circular(15.0)),
            // ):InputBorder.none,
            // errorText: widget.errorText,
            errorMaxLines: 4,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.errorText != null && widget.errorText != "" ? Colors.transparent : (widget.focusedBorderColor ?? AppColors.textFieldBorderColor),width: 1),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
            ),
            enabledBorder: widget.enabledBorder ??  OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
              borderSide: BorderSide(
                  color: widget.errorText != null && widget.errorText != "" ? Colors.transparent : (widget.outlineBorderColor ?? AppColors.textFieldBorderColor),width: 1
              ),
            ),
            disabledBorder: widget.enabledBorder ??  OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
              borderSide: BorderSide(
                  color: widget.outlineBorderColor ?? AppColors.textFieldBackgroundColor,width: 1.5
              ),
            ),
          ),
        ),
        widget.errorText != null && widget.errorText != "" ? buildSizeBox(4.0, 0.0) : SizedBox.shrink(),
        AnimatedSize(
          duration: Duration(milliseconds: 400),
          curve: Curves.linearToEaseOut,
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          child: Visibility(
            visible: widget.errorText != null && widget.errorText != "",
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: BuildText.buildText(text: widget.errorText ?? "",color: AppColors.redColor,fontFamily: FontFamily.medium,size: 12),
            )),
        )
      ],
    );
  }
}


class TextFieldForPhone extends StatelessWidget {
  final String? hint;
  final TextEditingController controller;
  final String? countryCode;
  final String initialCountryCode;
  final String? phoneCode;
  final bool? readOnly;
  final bool? ignoreCountryDialog;
  final Function(CountryCode)? onChangedCode;
  final String? errortext;
  final FocusNode? focusNode;
  const TextFieldForPhone({
    super.key,
    required this.hint,
    required this.controller,
    this.countryCode,
    required this.initialCountryCode,
    this.phoneCode,
    this.readOnly,
    this.ignoreCountryDialog,
    this.onChangedCode,
    this.errortext,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 54,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textFieldBorderColor,strokeAlign: BorderSide.strokeAlignOutside),
        color: AppColors.textFieldBackgroundColor,
        borderRadius: BorderRadius.circular(14)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IgnorePointer(
            ignoring: ignoreCountryDialog ?? false,
            child: CountryCodePicker(
              dialogSize: Size.fromHeight(Get.size.height*0.7),
              searchPadding: EdgeInsets.only(bottom: 20,left: 20,right: 20),
              searchDecoration: InputDecoration(
                  hintText: "Search",
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: AppColors.whiteColor)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: AppColors.whiteColor))
              ),
              barrierColor: AppColors.blackColor.withValues(alpha: 0.5),
              dialogBackgroundColor: Colors.grey.shade800,
              onChanged: onChangedCode,
              padding: EdgeInsets.zero,
              initialSelection: initialCountryCode,
              showCountryOnly: false,
              showDropDownButton: false,
              showOnlyCountryWhenClosed: false,
              alignLeft: false,
              enabled: readOnly == true ? false : true,
              showFlag: false,
              pickerStyle: PickerStyle.bottomSheet,
            ),
          ),
          Container(
            width: 1.2,
            height: 30,
            color: AppColors.textFieldBorderColor,
          ),

          Expanded(
            child: TextFieldCustom(
              readOnly: readOnly ?? false,
              hintText: hint,
              focusNode: focusNode,
              controller: controller,
              keyboardType: TextInputType.phone,
              errorText: errortext ?? "",
              enabledBorder: InputBorder.none,
              inputFormatters: [PhoneNumberFormatter()],
              focusedBorderColor: Colors.transparent,
            )
          )
        ],
      ),
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < digitsOnly.length && i < 10; i++) {
      if (i == 3 || i == 6) buffer.write('-');
      buffer.write(digitsOnly[i]);
    }

    String formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}