import 'package:get/get.dart';
import 'package:itunes_music_preview/module/main/main_page.dart';
import 'package:itunes_music_preview/routes/app_route.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class AppPage {
  const AppPage._();

  static final routes = [
    GetPage(name: AppRoute.main, page: () => MainPage())
  ];
}
