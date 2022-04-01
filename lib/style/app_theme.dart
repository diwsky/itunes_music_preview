import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itunes_music_preview/style/app_color.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class AppTheme {
  const AppTheme._();

  static final ThemeData theme = ThemeData(
    appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: AppColor.primary,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColor.primary,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light)),
    primaryColor: AppColor.primary,
    backgroundColor: CupertinoColors.systemGrey6,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: AppColor.accent, primary: AppColor.primary),
  );
}
