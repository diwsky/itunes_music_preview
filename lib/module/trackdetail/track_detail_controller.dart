import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_music_preview/api/music/music_track_response.dart';
import 'package:itunes_music_preview/module/app_controller.dart';
import 'package:itunes_music_preview/utility/app_error_utility.dart';
import 'package:itunes_music_preview/utility/app_exception.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:url_launcher/url_launcher.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/4/2022.

class TrackDetailController extends GetxController with AppController {
  final MusicTrackResponse item;
  TrackDetailController(this.item);

  Rx<Color> artworkColor = Colors.white.obs;

  @override
  void onInit() async {
    await _getArtWorkColor();
    super.onInit();
  }

  /// Doc : Get dominant color of Album Art Work image.
  /// @author rizkyagungramadhan@gmail.com on 04-Apr-2022, Mon, 13:22.
  _getArtWorkColor() async {
    try {
      final palette = await PaletteGenerator.fromImageProvider(
          CachedNetworkImageProvider(item.trackArtWorkUrl));
      artworkColor.value = palette.dominantColor?.color ?? Colors.white;
    } catch (error) {
      if (kDebugMode) showInformationSnackbar(error.toString());
    }
  }

  /// Doc : Launch an URL & open it in browser.
  /// @author rizkyagungramadhan@gmail.com on 04-Apr-2022, Mon, 13:21.
  launchUrl(String url) async {
    try {
      if (!await launch(url)) throw AppException("Could not launch $url");
    } catch (error, stacktrace) {
      showInformationSnackbar(error.toString());
      if (error is! AppException) AppErrorUtility.printInfo(stacktrace);
    }
  }
}
