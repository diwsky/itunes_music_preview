import 'package:itunes_music_preview/utility/app_exception.dart';
import 'package:json_annotation/json_annotation.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.
part 'response_list.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponseList<T> {
  @JsonKey(name: "resultCount")
  int? total;
  @JsonKey(name: "results")
  List<T>? data;
  String? status;
  @JsonKey(name: "errorMessage")
  String? message;

  ResponseList({this.total = 0, required this.data, this.status, this.message});

  /// Doc : @param response should be Map<String, dynamic> for cast to be successful.
  /// @author rizkyagungramadhan@gmail.com on 2021-12-13, Mon, 22:16.
  factory ResponseList.fromJson(
      dynamic response, T Function(Object? json) fromJsonT) {
    if (response is! Map<String, dynamic>) throw AppException("Response should be in Map types");
    return _$ResponseListFromJson(response, fromJsonT);
  }

  String get errorMessage =>
      (data is String ? data as String : message) ??
      (status is int
          ? "Oops something went error with code : $status"
          : "Unknown error");
}
