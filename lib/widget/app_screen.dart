import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:itunes_music_preview/style/app_color.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class AppScreen extends StatelessWidget {
  final Widget body;
  final bool isUsingKeyboard;

  const AppScreen({required this.body, this.isUsingKeyboard = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _mainScreen = Container(
      color: AppColor.primary,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        body: body,
      )),
    );

    return isUsingKeyboard
        ? KeyboardDismissOnTap(child: _mainScreen)
        : _mainScreen;
  }
}
