import 'package:itunes_music_preview/utility/app_exception.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.


class ResponseException implements AppException {

  @override
  String message;

  ResponseException(this.message);

  @override
  String toString() => message;
}