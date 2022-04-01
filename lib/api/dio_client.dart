import 'package:dio/dio.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:itunes_music_preview/utility/app_error_utility.dart';
import 'package:itunes_music_preview/utility/extension/response_ext.dart';
import 'package:itunes_music_preview/utility/response_exception.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class DioClient {
  // dio instance
  final Dio _dio;

  // injecting dio instance
  DioClient([Dio? dio]) : _dio = dio ?? Dio();

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Map<String, dynamic>? tokenHeader;
      // if(headers != null) {
      //   tokenHeader = await validateUserSession(headers);
      // }

      _dio.options.connectTimeout = 10 * 1000;
      _dio.options.receiveTimeout = 10 * 1000;
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: headers,
              // headers: tokenHeader ?? headers,
              followRedirects: false,
              receiveDataWhenStatusError: true,
              validateStatus: (status) => (status ?? 200) <= 503,
            ),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.parse();
    } on DioError catch (e) {
      printInfo(info: e.message);
      throw ResponseException(AppErrorUtility.handleError(e));
    } catch (e) {
      printInfo(info: e.toString());
      throw ResponseException(AppErrorUtility.handleError(e));
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      // _dio.interceptors.add(AppInterceptor(headers));;

      Map<String, dynamic>? tokenHeader;
      // if(headers != null) {
      //   tokenHeader = await validateUserSession(headers);
      // }
      _dio.options.connectTimeout = 10 * 1000;
      _dio.options.receiveTimeout = 10 * 1000;
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: headers,
              // headers: tokenHeader ?? headers,
              followRedirects: false,
              receiveDataWhenStatusError: true,
              validateStatus: (status) => (status ?? 200) <= 503,
            ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.parse();
    } on DioError catch (e) {
      printInfo(info: e.message);
      throw ResponseException(AppErrorUtility.handleError(e));
    } catch (e) {
      printInfo(info: e.toString());
      throw ResponseException(AppErrorUtility.handleError(e));
    }
  }
}

extension DioClientExt on DioClient {}
