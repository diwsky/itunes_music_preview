// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseList<T> _$ResponseListFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ResponseList<T>(
      total: json['resultCount'] as int? ?? 0,
      data: (json['results'] as List<dynamic>?)?.map(fromJsonT).toList(),
      status: json['status'] as String?,
      message: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$ResponseListToJson<T>(
  ResponseList<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'resultCount': instance.total,
      'results': instance.data?.map(toJsonT).toList(),
      'status': instance.status,
      'errorMessage': instance.message,
    };
