import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_music_preview/common/placeholder_type.dart';
import 'package:itunes_music_preview/style/app_dimen.dart';
import 'package:itunes_music_preview/style/app_text_style.dart';
import 'package:lottie/lottie.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class PlaceholderWidget extends StatelessWidget {
  final double? height;
  final PlaceholderType type;

  const PlaceholderWidget({Key? key, this.height, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.all(AppDimen.paddingExtraLarge4),
      child: Column(
        children: [
          Lottie.asset(type.animationPath, height: height ?? Get.height / 4),
          const SizedBox(height: AppDimen.paddingExtraSmall),
          Text(
            type.description,
            style: AppTextStyle.regular(),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
