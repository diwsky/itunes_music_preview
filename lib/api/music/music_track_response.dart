import 'package:itunes_music_preview/utility/app_exception.dart';
import 'package:json_annotation/json_annotation.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

part "music_track_response.g.dart";

@JsonSerializable()
class MusicTrackResponse {

  String artistName;
  String artistViewUrl;
  String collectionName;
  String collectionViewUrl;
  String trackName;
  String trackViewUrl;
  @JsonKey(name: "previewUrl")
  String? previewStreamUrl;
  @JsonKey(name: "trackTimeMillis")
  num? trackTimeInMillis;
  @JsonKey(name: "artworkUrl100")
  String trackArtWorkUrl;
  DateTime releaseDate;
  @JsonKey(name: "primaryGenreName")
  String? genre;
  dynamic trackPrice;
  @JsonKey(name: "currency")
  dynamic priceCurrency;
  bool isStreamable;

  MusicTrackResponse(
      this.artistName,
      this.artistViewUrl,
      this.collectionName,
      this.collectionViewUrl,
      this.trackName,
      this.trackViewUrl,
      this.previewStreamUrl,
      this.trackTimeInMillis,
      this.trackArtWorkUrl,
      this.releaseDate,
      this.genre,
      this.trackPrice,
      this.priceCurrency,
      this.isStreamable);

  factory MusicTrackResponse.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) throw AppException("MusicTrackResponse should be in Map types");
    return _$MusicTrackResponseFromJson(json);
  }
}