import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_music_preview/api/music/music_track_response.dart';
import 'package:itunes_music_preview/api/response_list.dart';
import 'package:itunes_music_preview/utility/app_exception.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/4/2022.

void main() {
  test("Response List parsed successfully when no response", () {
    ///Create an empty response
    final Map<String, dynamic> response = {};

    ///Expect [ResponseList] should parsed with empty data
    expect(ResponseList<dynamic>.fromJson(response, (_) => null),
        isA<ResponseList>());
  });

  test("Response List throw error when data was not Map<String, dynamic>", () {
    ///Create a null response
    Map<String, dynamic>? response;

    ///Expect [ResponseList] should throw an [AppException]
    expect(() => ResponseList<dynamic>.fromJson(response, (_) => null),
        throwsA(isA<AppException>()));
  });

  test(
      "Response List parsed successfully with generic data type (MusicTrackResponse)",
      () async {
    ///Ensure all assets is accessible before executing test
    TestWidgetsFlutterBinding.ensureInitialized();

    ///Simulate response (json) from an asset file
    final result = await rootBundle
        .loadString("assets/music_track_response.json")
        .then((jsonString) {
      ///Parse json file
      var jsonMap = json.decode(jsonString);

      ///Parse into ResponseList<MusicTrackResponse>
      return ResponseList<MusicTrackResponse>.fromJson(
          jsonMap, (json) => MusicTrackResponse.fromJson(json));
    });

    ///Expected first data to be type of [MusicTrackResponse]
    expect(result.data?.first, isA<MusicTrackResponse>());
  });
}
