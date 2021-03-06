import 'package:dio/dio.dart';
import 'package:itunes_music_preview/api/url_setting.dart';
import 'package:itunes_music_preview/utility/app_error_utility.dart';
import 'package:itunes_music_preview/utility/extension/response_ext.dart';
import 'package:itunes_music_preview/utility/response_exception.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class DioClient {
  late final Dio _dio;

  DioClient();

  factory DioClient.initialize() {
    ///Initialize [DioClient] (only once) for API usage
    final dioInstance = Dio(BaseOptions(
        baseUrl: UrlSetting.baseUrl,
        connectTimeout: UrlSetting.maxConnectTimeOut,
        receiveTimeout: UrlSetting.maxReceiveTimeOut,
        sendTimeout: UrlSetting.maxSendTimeOut,
        receiveDataWhenStatusError: true,
        validateStatus: (status) => (status ?? 200) <= 503));
    return DioClient().._dio = dioInstance;
  }

  /// Doc : Use it for [GET] method.
  /// Use [options] if you want to override [BaseOptions] provided inside [initialize]
  /// @author rizkyagungramadhan@gmail.com on 01-Apr-2022, Fri, 21:18.
  Future<dynamic> get(String uriPath,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final Response response = await _dio.get(uriPath,
          queryParameters: queryParameters, options: options);
      return response.parse();
    } on DioError catch (e) {
      AppErrorUtility.printInfo(e.message);
      throw ResponseException(AppErrorUtility.handleError(e));
    } catch (e) {
      AppErrorUtility.printInfo(e);
      throw ResponseException(AppErrorUtility.handleError(e));
    }
  }

  /// Doc : Use it for [POST] method.
  /// Use [options] if you want to override [BaseOptions] provided inside [initialize]
  /// @author rizkyagungramadhan@gmail.com on 01-Apr-2022, Fri, 21:18.
  Future<dynamic> post(String uriPath,
      {data, Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final Response response = await _dio.post(
        uriPath,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.parse();
    } on DioError catch (e) {
      AppErrorUtility.printInfo(e.message);
      throw ResponseException(AppErrorUtility.handleError(e));
    } catch (e) {
      AppErrorUtility.printInfo(e);
      throw ResponseException(AppErrorUtility.handleError(e));
    }
  }
}
