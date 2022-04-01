import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_music_preview/common/app_state.dart';
import 'package:itunes_music_preview/common/placeholder_type.dart';
import 'package:itunes_music_preview/module/main/main_controller.dart';
import 'package:itunes_music_preview/module/main/music_item_view.dart';
import 'package:itunes_music_preview/style/app_color.dart';
import 'package:itunes_music_preview/utility/extension/widget_ext.dart';
import 'package:itunes_music_preview/widget/app_screen.dart';
import 'package:itunes_music_preview/widget/placeholder_widget.dart';
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
          mainAxisSize: MainAxisSize.max,
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
                    child: (() {
                      ///Manage state

                      if (!_controller.isConnectionAvailable.value) {
                        ///Return when no internet connection
                        return const PlaceholderWidget(
                                type: PlaceholderType.noConnection)
                            .asScrollable();
                      }

                      switch (_controller.appState.value) {
                        case AppState.idle:
                          return const PlaceholderWidget(
                              type: PlaceholderType.typeASearch);
                        case AppState.loading:
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColor.primary,
                            ),
                          );
                        case AppState.failed:
                          return const PlaceholderWidget(
                                  type: PlaceholderType.somethingWentWrong)
                              .asScrollable();
                        case AppState.completed:
                          return _buildMusicList();
                        default:
                          return const SizedBox.shrink();
                      }
                    }()),
                  )),
            )
          ],
        ));
  }

  Widget _buildMusicList() {
    return Column(
      children: [
        ///Music List Item View
        Expanded(
          child: _controller.results.isEmpty
              ? const PlaceholderWidget(type: PlaceholderType.noData)
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _controller.results.length,
                  itemBuilder: (_, position) => MusicItemView(
                      item: _controller.results[position], onPressed: () {})),
        ),
      ],
    );
  }
}
