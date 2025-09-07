
import 'package:cached_network_image/cached_network_image.dart';
import 'package:education/core/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../constants/color.dart';
import '../constants/string_define.dart';

class BaseImage{

  static final BaseImage _singleton = BaseImage._internal();
  factory BaseImage() {
    return _singleton;
  }
  BaseImage._internal();

  static image({required String path,BoxFit? fit, double? height,double? width,Color? color}){
    return Image.asset(path,height: height,width: width,fit: fit,color: color);
  }

  static svgPicture({required String path,BoxFit? fit, double? height,double? width,Color? color}){
    return SvgPicture.asset(path,height: height,width: width,colorFilter: ColorFilter.mode(color!, BlendMode.srcIn));
  }

  static Widget assetImage({
    required String path,
    required double height,
    required double width,
    double? imageHeight,
    double? imageWidth,
    Color? bgColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    bool isCircular = false,
    BoxFit fit = BoxFit.cover,
    double? padding,
  }) {
    final Widget imageWidget = path.trim().toLowerCase().endsWith(".png")
        ? Image.asset(
      path,
      fit: fit,
      height: imageHeight,
      width: imageWidth,
    )
        : SvgPicture.asset(
      path,
      fit: fit,
      height: imageHeight,
      width: imageWidth,
    );

    final decoratedContainer = Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding ?? 0.0),
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.textFieldBorderColor,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 0.0,
        ),
        shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircular ? null : BorderRadius.circular(borderRadius ?? 10.0),
      ),
      child: imageWidget,
    );

    return isCircular
        ? ClipOval(child: decoratedContainer)
        : ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
      child: decoratedContainer,
    );
  }


  static cacheNetworkImage({
    required String path,
    required double height,
    required double width,
    Color? bgColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    BoxShape? shape,
    BoxFit? fit,
    PlaceholderWidgetBuilder? placeholder,
    Widget Function(BuildContext, String, DownloadProgress)? progressBuilder,

  }){
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.transparent,width: borderWidth ?? 0.0),
          // borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
          shape: borderRadius != null ? BoxShape.rectangle : (shape ?? BoxShape.circle),
          color: bgColor ?? AppColors.whiteColor
      ),
      child: CachedNetworkImage(
        key: GlobalKey(),
        filterQuality: FilterQuality.high,
        imageUrl: path,
        fit: fit ?? BoxFit.cover,
        errorWidget: (context, url, error) => placeHolderWidget(),
        // placeholderFadeInDuration: const Duration(milliseconds: 300),
        fadeOutDuration: const Duration(milliseconds: 200),
        progressIndicatorBuilder: progressBuilder,
        placeholder: placeholder ?? (context, url) {
          return placeHolderWidget();
        },
      )
    );
  }





  static Widget placeHolderWidget() {
    return Container(
        alignment: Alignment.center,
        color: AppColors.textFieldBorderColor,
        child: Stack(
          children: [
            Image.asset(AppString.logo,fit: BoxFit.cover,width: Get.width,height: Get.height),
            Container(
              height: Get.height,
              width: Get.width,
              color: AppColors.whiteColor.withValues(alpha:0.9),
            )
          ],
        )
    );
  }

  static noDataFoundWidget(){
    return Center(child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.translate(
            offset: const Offset(0, -25),
            child: BuildText.buildText(text: "No Data Found",color: Colors.grey,weight: FontWeight.w600,size: 15)),
      ],
    ));
  }

}