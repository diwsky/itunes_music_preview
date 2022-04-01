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
  RxBool isConnectionAvailable = true.obs;

  search({required String artistName}) async {
    try {
      if (isLoading.value) return;
      isLoading.value = true;

      ///Validate connection availability
      await forceToConnected(isConnectionAvailable);

      ///Execute API Call
      return await _repository
          .searchByArtistName(
              request: MusicTrackRequest(artistName: artistName))
          .then((response) {

        ///Validate response
        response.validate();

        ///Assign all response data when valid
        results.assignAll(response.data ?? []);
        isLoading.value = false;
      });
    } catch (error, stacktrace) {
      isLoading.value = false;
      showInformationSnackbar(error);
      if (error is! AppException && kDebugMode) {
        printInfo(info: stacktrace.toString());
      }
    }
  }
}
