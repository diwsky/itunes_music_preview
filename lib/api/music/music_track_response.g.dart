// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_track_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicTrackResponse _$MusicTrackResponseFromJson(Map<String, dynamic> json) =>
    MusicTrackResponse(
      json['artistName'] as String,
      json['artistViewUrl'] as String,
      json['collectionName'] as String,
      json['collectionViewUrl'] as String,
      json['trackName'] as String,
      json['trackViewUrl'] as String,
      json['previewUrl'] as String?,
      json['trackTimeMillis'] as num?,
      json['artworkUrl100'] as String,
      DateTime.parse(json['releaseDate'] as String),
      json['primaryGenreName'] as String?,
      json['trackPrice'],
      json['currency'],
      json['isStreamable'] as bool,
    );

Map<String, dynamic> _$MusicTrackResponseToJson(MusicTrackResponse instance) =>
    <String, dynamic>{
      'artistName': instance.artistName,
      'artistViewUrl': instance.artistViewUrl,
      'collectionName': instance.collectionName,
      'collectionViewUrl': instance.collectionViewUrl,
      'trackName': instance.trackName,
      'trackViewUrl': instance.trackViewUrl,
      'previewUrl': instance.previewStreamUrl,
      'trackTimeMillis': instance.trackTimeInMillis,
      'artworkUrl100': instance.trackArtWorkUrl,
      'releaseDate': instance.releaseDate.toIso8601String(),
      'primaryGenreName': instance.genre,
      'trackPrice': instance.trackPrice,
      'currency': instance.priceCurrency,
      'isStreamable': instance.isStreamable,
    };
