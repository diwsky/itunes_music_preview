import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_music_preview/api/music/music_track_request.dart';
import 'package:itunes_music_preview/api/music/music_track_response.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/4/2022.

void main() {
  group("Music Track Response", () {
    test("Response should be parsed successfully", () {
      ///Create complete response
      final Map<String, dynamic> response = {
        "wrapperType": "track",
        "kind": "song",
        "artistId": 329938300,
        "collectionId": 669224780,
        "trackId": 669224964,
        "artistName": "Asking Alexandria",
        "collectionName": "From Death to Destiny",
        "trackName": "Moving On",
        "collectionCensoredName": "From Death to Destiny",
        "trackCensoredName": "Moving On",
        "artistViewUrl":
            "https://music.apple.com/us/artist/asking-alexandria/329938300?uo=4",
        "collectionViewUrl":
            "https://music.apple.com/us/album/moving-on/669224780?i=669224964&uo=4",
        "trackViewUrl":
            "https://music.apple.com/us/album/moving-on/669224780?i=669224964&uo=4",
        "previewUrl":
            "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/7c/4f/f2/7c4ff21a-f888-500e-d756-20189a87817f/mzaf_13846024196916913701.plus.aac.p.m4a",
        "artworkUrl30":
            "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/10/5a/7c/105a7ced-455c-eca8-c3a4-ef041bc0f30d/source/30x30bb.jpg",
        "artworkUrl60":
            "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/10/5a/7c/105a7ced-455c-eca8-c3a4-ef041bc0f30d/source/60x60bb.jpg",
        "artworkUrl100":
            "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/10/5a/7c/105a7ced-455c-eca8-c3a4-ef041bc0f30d/source/100x100bb.jpg",
        "collectionPrice": 9.99,
        "trackPrice": 1.29,
        "releaseDate": "2013-08-05T12:00:00Z",
        "collectionExplicitness": "explicit",
        "trackExplicitness": "notExplicit",
        "discCount": 1,
        "discNumber": 1,
        "trackCount": 13,
        "trackNumber": 10,
        "trackTimeMillis": 242593,
        "country": "USA",
        "currency": "USD",
        "primaryGenreName": "Hard Rock",
        "isStreamable": true
      };

      ///Expect [response] to be parsed successfully
      expect(MusicTrackResponse.fromJson(response), isA<MusicTrackResponse>());
    });
  });

  group("Music Track Request", () {
    test("Request object should be parsed into Map<String, dynamic>", () {
      ///Create [MusicTrackRequest] with artistName Lenka
      final request = MusicTrackRequest(artistName: "Lenka");

      ///Convert [MusicTrackRequest] into Map<String, dynamic>
      final mapOfRequest = request.toJson();

      ///Expect [mapOfRequest] executed successfully
      expect(mapOfRequest, isA<Map<String, dynamic>>());

      ///Expect the JsonKey annotation work to change [artistName] into [term] when converted into Map<String, dynamic>
      expect(mapOfRequest["term"], equals("Lenka"));
    });

    test("Request object should have some default value", () {
      ///Create [MusicTrackRequest] with artistName Lenka
      final request = MusicTrackRequest(artistName: "");

      ///Convert [MusicTrackRequest] into Map<String, dynamic>
      final mapOfRequest = request.toJson();

      ///Expect the JsonKey annotation change some key when converted into Map<String, dynamic>
      ///Expect request has some default value (except [term]) when converted into Map<String, dynamic>
      expect(mapOfRequest["term"], isEmpty);
      expect(mapOfRequest["entity"], isNotEmpty);
      expect(mapOfRequest["attribute"], isNotEmpty);
      expect(mapOfRequest["limit"], isPositive);
    });
  });
}
