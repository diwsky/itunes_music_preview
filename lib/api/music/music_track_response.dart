import 'package:itunes_music_preview/utility/app_exception.dart';
import 'package:json_annotation/json_annotation.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

part "music_track_response.g.dart";

@JsonSerializable()
class MusicTrackResponse {

  final int trackId;
  final String artistName;
  final String artistViewUrl;
  final String collectionName;
  final String collectionViewUrl;
  final String trackName;
  final String trackViewUrl;
  @JsonKey(name: "previewUrl")
  final String? previewStreamUrl;
  @JsonKey(name: "trackTimeMillis")
  final num? trackTimeInMillis;
  @JsonKey(name: "artworkUrl100")
  final String trackArtWorkUrl;
  final DateTime releaseDate;
  @JsonKey(name: "primaryGenreName")
  final String? genre;
  final dynamic trackPrice;
  @JsonKey(name: "currency")
  final dynamic priceCurrency;
  final bool isStreamable;

  MusicTrackResponse(
      this.trackId,
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