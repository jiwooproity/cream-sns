import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class PrettyLogger extends Interceptor {
  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    const encoder = JsonEncoder.withIndent('  ');
    if (kDebugMode) {
      print('RESPONSE [${response.statusCode}]');
      print(encoder.convert(response.data));
    }
    super.onResponse(response, handler);
  }
}