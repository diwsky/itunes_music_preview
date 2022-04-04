import 'package:equatable/equatable.dart';
import 'package:itunes_music_preview/utility/app_exception.dart';
import 'package:itunes_music_preview/utility/extension/string_ext.dart';
import 'package:itunes_music_preview/utility/response_exception.dart';
import 'package:json_annotation/json_annotation.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.
part 'response_list.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponseList<T> extends Equatable{
  @JsonKey(name: "resultCount")
  final int? total;
  @JsonKey(name: "results")
  final List<T>? data;
  final String? status;
  @JsonKey(name: "errorMessage")
  final String? message;

  const ResponseList({this.total = 0, required this.data, this.status, this.message});

  /// Doc : [response] should be [Map<String, dynamic>] for cast to be successful.
  /// @author rizkyagungramadhan@gmail.com on 01-Apr-2022, Fri, 16:55.
  factory ResponseList.fromJson(
      dynamic response, T Function(Object? json) fromJsonT) {
    if (response is! Map<String, dynamic>) throw AppException("Response should be in Map types");
    return _$ResponseListFromJson(response, fromJsonT);
  }

  /// Doc : Validate Response. Will throw [ResponseException] with [errorMessage] inside it when failed.
  /// @author rizkyagungramadhan@gmail.com on 01-Apr-2022, Fri, 18:01.
  void validate() {
    if ((data ?? []).isNotEmpty && errorMessage.isNotNullOrEmpty) return;
    throw ResponseException(errorMessage);
  }

  String get errorMessage =>
      (data is String ? data as String : message) ??
      (status is int
          ? "Oops something went wrong with error code : $status"
          : "Unknown error");

  @override
  List<Object?> get props => [total, data, status, message];
}
