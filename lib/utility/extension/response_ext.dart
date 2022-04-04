import 'dart:convert';

import 'package:dio/dio.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.


extension ResponseExt on Response {
  dynamic parse() {
    if (data is String) return jsonDecode(data);
    return data;
  }
}