import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:itunes_music_preview/api/music/music_track_request.dart';
import 'package:itunes_music_preview/api/music/music_track_response.dart';
import 'package:itunes_music_preview/module/app_controller.dart';
import 'package:itunes_music_preview/module/repository.dart';
import 'package:itunes_music_preview/utility/app_exception.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class MainController extends GetxController with AppController {
  final _repository = Get.find<Repository>();
  RxBool isLoading = false.obs;
  RxList results = RxList<MusicTrackResponse>();

  search({required String artistName}) async {
    try {
      if (isLoading.value) return;
      isLoading.value = true;

      return await _repository
          .searchByArtistName(
              request: MusicTrackRequest(artistName: artistName))
          .then((response) {
        response.validate();
        results.assignAll(response.data ?? []);
        isLoading.value = false;
      });

    } catch (error, stacktrace) {
      isLoading.value = false;
      showInformationSnackbar(error.toString());
      if (error is! AppException && kDebugMode) {
        printInfo(info: stacktrace.toString());
      }
    }
  }
}
