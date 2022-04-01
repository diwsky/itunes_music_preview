// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_track_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicTrackRequest _$MusicTrackRequestFromJson(Map<String, dynamic> json) =>
    MusicTrackRequest(
      artistName: json['term'] as String,
      type: json['entity'] as String? ?? "musicTrack",
      attribute: json['attribute'] as String? ?? "allArtistTerm",
      limit: json['limit'] as int? ?? 20,
    );

Map<String, dynamic> _$MusicTrackRequestToJson(MusicTrackRequest instance) =>
    <String, dynamic>{
      'term': instance.artistName,
      'entity': instance.type,
      'attribute': instance.attribute,
      'limit': instance.limit,
    };
