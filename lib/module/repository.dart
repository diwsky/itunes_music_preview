import 'package:dio/dio.dart';
import 'package:itunes_music_preview/api/dio_client.dart';
import 'package:itunes_music_preview/api/music/music_api.dart';
import 'package:itunes_music_preview/api/music/music_track_request.dart';
import 'package:itunes_music_preview/api/music/music_track_response.dart';
import 'package:itunes_music_preview/api/response_list.dart';
import 'package:itunes_music_preview/api/url_setting.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class Repository {
  ///API
  late final MusicApi _musicApi;

  Repository();

  factory Repository.initialize() {
    ///Configure [Dio] instance inside [DioClient] factory constructor
    final dioClient = DioClient.initialize();

    return Repository().._musicApi = MusicApi(dioClient);
  }

  ///API Calls
  Future<ResponseList<MusicTrackResponse>> searchByArtistName(
          {required MusicTrackRequest request}) async =>
      await _musicApi.search(request);
}
