import 'package:dio/dio.dart';
import 'package:itunes_music_preview/api/dio_client.dart';
import 'package:itunes_music_preview/api/music/music_api.dart';
import 'package:itunes_music_preview/api/music/music_track_request.dart';
import 'package:itunes_music_preview/api/music/music_track_response.dart';
import 'package:itunes_music_preview/api/response_list.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class Repository {
  ///API
  late final MusicApi _musicApi;

  Repository();

  factory Repository.initialize() {
    ///Initialize [DioClient] (only once) for API usage
    final dioInstance = Dio(BaseOptions(
        baseUrl: "https://itunes.apple.com",
        connectTimeout: 10 * 1000,
        receiveTimeout: 10 * 1000,
        receiveDataWhenStatusError: true,
        validateStatus: (status) => (status ?? 200) <= 503));
    final dioClient = DioClient(dioInstance);

    return Repository().._musicApi = MusicApi(dioClient);
  }

  ///API Calls
  Future<ResponseList<MusicTrackResponse>> searchByArtistName(
          {required MusicTrackRequest request}) async =>
      await _musicApi.search(request);
}
