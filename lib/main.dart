import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_music_preview/module/app.dart';
import 'package:itunes_music_preview/module/repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ///Create & Inject [Repository]
  final repository = Repository.initialize();
  Get.put(repository);

  runApp(const App());
}