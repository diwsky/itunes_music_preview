import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_music_preview/module/main/main_controller.dart';
import 'package:itunes_music_preview/module/main/music_item_view.dart';
import 'package:itunes_music_preview/style/app_dimen.dart';
import 'package:itunes_music_preview/widget/app_screen.dart';
import 'package:itunes_music_preview/widget/search_text_field.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  final _controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    final searchTextController = TextEditingController();

    return AppScreen(
        isUsingKeyboard: true,
        body: Column(
          children: [
            SearchTextField(
              textEditingController: searchTextController,
              placeholder: "Search by artist name",
              onSearch: (artistName) =>
                  _controller.search(artistName: artistName),
            ),

            ///Observable Widgets
            Expanded(
              child: Obx(() => RefreshIndicator(
                    onRefresh: () async => await _controller.search(
                        artistName: searchTextController.text),
                    child: Column(
                      children: [
                        ///Music List Item View
                        // const SizedBox(height: AppDimen.paddingMedium),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                              // separatorBuilder: (_, __) => const Divider(),
                              itemCount: _controller.results.length,
                              itemBuilder: (_, position) => MusicItemView(
                                  item: _controller.results[position],
                                  onPressed: () {})),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ));
  }
}
