import 'package:dio/dio.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.


class AppErrorUtility {
  static String handleError(dynamic error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with server";
          break;
        case DioErrorType.other:
          errorDescription =
          "Connection to server failed due to internet connection";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with server";
          break;
        case DioErrorType.response:
          errorDescription = error.response?.statusCode != null
              ? "Received invalid status code: ${error.response?.statusCode}"
              : "Oops something went wrong :\n ${error.response?.statusMessage != null ? error.response!.statusMessage : "Unknown error"}";
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with server";
          break;
      }
    } else {
      errorDescription = "$error";
    }
    if(errorDescription.isEmpty) {
      errorDescription = "Oops something went wrong";
    }
    return errorDescription;
  }
}
