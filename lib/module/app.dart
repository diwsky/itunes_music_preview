import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_music_preview/routes/app_page.dart';
import 'package:itunes_music_preview/routes/app_route.dart';
import 'package:itunes_music_preview/style/app_theme.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      theme: AppTheme.theme,
      initialRoute: AppRoute.main,
      locale: Get.deviceLocale,
      getPages: AppPage.routes,
    );
  }
}
