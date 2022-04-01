import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:itunes_music_preview/style/app_dimen.dart';
import 'package:itunes_music_preview/style/app_text_style.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

mixin AppController {
  /// Doc : Avoid using with navigating to new page. Bcs snackbar loose his context.
  /// @author rizkyagungramadhan@gmail.com on 01-Apr-2022, Fri, 18:10.
  showInformationSnackbar(String message) {
    if (Get.isSnackbarOpen) return;
    Get.snackbar('', '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: CupertinoColors.systemGrey4,
        titleText: Center(
          child: Text(
            "Information",
            maxLines: 1,
            style: AppTextStyle.light(),
          ),
        ),
        messageText: Center(
          child: Text(
            message,
            style: AppTextStyle.regular(),
          ),
        ),
        margin: const EdgeInsets.only(bottom: AppDimen.paddingLarge));
  }
}
