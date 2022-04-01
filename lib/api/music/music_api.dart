import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:itunes_music_preview/api/dio_client.dart';
import 'package:itunes_music_preview/api/music/music_track_request.dart';
import 'package:itunes_music_preview/api/music/music_track_response.dart';
import 'package:itunes_music_preview/api/response_list.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class MusicApi {
  final DioClient _dioClient;

  MusicApi(this._dioClient);

  static const _searchAction = "search";

  Future<ResponseList<MusicTrackResponse>> search(
      MusicTrackRequest request) async {
    return await rootBundle
        .loadString("assets/music_track_response.json")
        .then((jsonString) {
      var jsonMap = json.decode(jsonString);
      return ResponseList<MusicTrackResponse>.fromJson(jsonMap,
          (json) => MusicTrackResponse.fromJson(json as Map<String, dynamic>));
    });
  }
}
