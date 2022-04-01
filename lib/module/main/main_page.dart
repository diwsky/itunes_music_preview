import 'package:flutter/material.dart';
import 'package:itunes_music_preview/widget/app_screen.dart';
import 'package:itunes_music_preview/widget/search_text_field.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScreen(
        isUsingKeyboard: true,
        body: Column(
          children: [
            SearchTextField(placeholder: "Search by artist name"),
          ],
        ));
  }
}
