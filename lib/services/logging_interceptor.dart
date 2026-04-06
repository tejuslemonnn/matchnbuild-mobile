import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggingInterceptor extends Interceptor {
  final int _maxCharactersPerLine = 200;

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //TODO: CEK TOKEN AUTH
    // String? token = prefs.getString(Common.TOKEN);
    String? token = null;
    if (token != null) {
      options.headers.addAll({'Authorization': "Bearer $token"});
    }
    if (kDebugMode) {
      print("--> ${options.method} ${options.baseUrl}${options.path}");
      print("params: ${options.queryParameters}");
      print("<-- END HTTP");
    }
    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print(
        "<--response: ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}",
      );
    }
    String responseAsString = response.data.toString();
    if (responseAsString.length > _maxCharactersPerLine) {
      int iterations = (responseAsString.length / _maxCharactersPerLine)
          .floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        if (kDebugMode) {
          print(
            responseAsString.substring(i * _maxCharactersPerLine, endingIndex),
          );
        }
      }
    } else {
      if (kDebugMode) {
        print(response.data);
      }
    }
    if (kDebugMode) {
      print("<-- END HTTP");
    }

    return super.onResponse(response, handler);
  }

  @override
  onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print("<-- Error -->");
      print(err.error);
      print(err.message);
    }
    return super.onError(err, handler);
  }
}
