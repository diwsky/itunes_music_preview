import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:itunes_music_preview/module/app.dart';
import 'package:itunes_music_preview/module/repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ///TODO : Is app should be forced to portrait? If yes on iOS should add <string>UIInterfaceOrientationPortrait</string> into Info.plist.
  ///written by rizkyagungramadhan@gmail.com on 04-Apr-2022, Mon, 06:18.

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  ///Create & Inject [Repository]
  final repository = Repository.initialize();
  Get.put(repository);

  runApp(const App());
}
