
import 'package:cached_network_image/cached_network_image.dart';
import 'package:education/core/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/color.dart';
import '../constants/string_define.dart';
import '../services/api/web_constants.dart';

class ImageHelperCustom extends StatelessWidget{
  final String? userName;
  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Alignment? alignment;
  final PlaceholderWidgetBuilder? placeholder;
  final Widget Function(BuildContext, String, DownloadProgress)? progressBuilder;

  const ImageHelperCustom({ super.key, this.userName, this.placeholder, required this.image,  this.height,   this.width,  required this.fit,  this.alignment,this.progressBuilder });


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholderFadeInDuration: Duration(milliseconds: 0),
      key: GlobalKey(),
      filterQuality: FilterQuality.high,
      maxHeightDiskCache: height?.round(),
      maxWidthDiskCache: width?.round(),
      imageUrl: image.trim().toString().contains("http") ? image : "${ApiUrl.kDomain}$image",
      fit: fit,
      alignment: alignment ?? Alignment.center,
      errorWidget: (context, url, error) => placeHolderWidget(userName: userName),
      fadeOutDuration: const Duration(milliseconds: 200),
      progressIndicatorBuilder: progressBuilder,
      placeholder: placeholder ?? (context, url) {
        return placeHolderWidget(userName: userName);
        // ShimmerCustom(
        //   isLoading: true,
        //   widget: SizedBox(
        //     height: Get.height,
        //     width: Get.width,
        //   ),
        // );
      },
    );
  }

  static Widget placeHolderWidget({String? userName}) {
    return Container(
        alignment: Alignment.center,
        color: Colors.grey.shade400,
        child: Stack(
          children: [
            userName == null || userName == "" ?
            Center(child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(AppString.userDemo,fit: BoxFit.contain,width: 100,height: 100,color: Colors.grey.shade500,),
            )) :
            Container(
              height: Get.height,
              width: Get.width,
              alignment: Alignment.center,
              color: AppColors.whiteColor.withValues(alpha:0.7),
              child: Visibility(
                  visible: userName != "",
                  child: BuildText.buildText(text: "${userName.split(" ").first[0]}${userName.split(" ").last[0]}",size: 22,color: AppColors.blackColor)),
            )
          ],
        )
    );
  }
}