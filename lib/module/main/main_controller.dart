import 'package:get/get.dart';
import 'package:itunes_music_preview/api/music/music_track_request.dart';
import 'package:itunes_music_preview/api/music/music_track_response.dart';
import 'package:itunes_music_preview/common/app_state.dart';
import 'package:itunes_music_preview/module/app_controller.dart';
import 'package:itunes_music_preview/module/repository.dart';
import 'package:itunes_music_preview/utility/app_error_utility.dart';
import 'package:itunes_music_preview/utility/app_exception.dart';
import 'package:itunes_music_preview/utility/extension/string_ext.dart';
import 'package:just_audio/just_audio.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class MainController extends GetxController with AppController {
  final _repository = Get.find<Repository>();
  RxList results = RxList<MusicTrackResponse>();
  RxBool isConnectionAvailable = true.obs;
  Rx<AppState> appState = AppState.idle.obs;
  Rxn<MusicTrackResponse> selectedMusic = Rxn<MusicTrackResponse>();
  final AudioPlayer audioPlayer = AudioPlayer();


  @override
  void onInit() {
    search(artistName: "artistName");
    super.onInit();
  }

  search({required String artistName}) async {
    try {
      ///Reset selected music
      _updateSelectedMusic();

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

  playTrack(MusicTrackResponse item) async {
    try {
      if (item.previewStreamUrl.isNullOrEmpty) {
        throw AppException("Stream url for this track cannot be found");
      }

      await audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(item.previewStreamUrl!),
        ),
        initialPosition: Duration.zero,
        preload: true,
      );
      audioPlayer.play();
      _updateSelectedMusic(item);

    } on PlayerException catch (e) {
      showInformationSnackbar(e.message);
    } on PlayerInterruptedException catch (e) {
      showInformationSnackbar(e.message);
    } catch (error, stacktrace) {
      showInformationSnackbar(error);
      if (error is! AppException) AppErrorUtility.printInfo(stacktrace);
    }
  }

  _updateSelectedMusic([MusicTrackResponse? item]) {
    selectedMusic.value = item;
    results.refresh();
  }
}
