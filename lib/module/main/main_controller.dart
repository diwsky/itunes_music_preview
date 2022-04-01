import 'package:get/get.dart';
import 'package:itunes_music_preview/api/music/music_track_request.dart';
import 'package:itunes_music_preview/api/music/music_track_response.dart';
import 'package:itunes_music_preview/common/app_state.dart';
import 'package:itunes_music_preview/module/app_controller.dart';
import 'package:itunes_music_preview/module/repository.dart';
import 'package:itunes_music_preview/utility/app_error_utility.dart';
import 'package:itunes_music_preview/utility/app_exception.dart';
import 'package:itunes_music_preview/utility/extension/string_ext.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class MainController extends GetxController with AppController {
  final _repository = Get.find<Repository>();
  RxList results = RxList<MusicTrackResponse>();
  RxBool isConnectionAvailable = true.obs;
  Rx<AppState> appState = AppState.idle.obs;

  search({required String artistName}) async {
    try {
      ///Prevent this function called repetitively
      if (appState.value == AppState.loading) return;
      appState.value = AppState.loading;

      ///Show search animation when [artistName] query was empty
      if (artistName.isNullOrEmpty) return appState.value = AppState.idle;

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
        appState.value = AppState.completed;
      });
    } catch (error, stacktrace) {
      appState.value = AppState.failed;
      showInformationSnackbar(error);
      if (error is! AppException) AppErrorUtility.printInfo(stacktrace);
    }
  }
}
