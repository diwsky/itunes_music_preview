import 'package:itunes_music_preview/api/i_request.dart';
import 'package:json_annotation/json_annotation.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

part "music_track_request.g.dart";

@JsonSerializable()
class MusicTrackRequest implements IRequest{
  @JsonKey(name: "term")
  String artistName;

  @JsonKey(name: "entity")
  String? type;

  String? attribute;

  int? limit;

  MusicTrackRequest({
    required this.artistName, this.type = "musicTrack", this.attribute = "allArtistTerm", this.limit = 20});

  @override
  Map<String, dynamic> toJson() => _$MusicTrackRequestToJson(this);

}