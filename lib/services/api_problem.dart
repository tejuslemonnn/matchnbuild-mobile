import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> doExpires() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // TODO: CEK TOKEN
  // prefs.remove(Common.TOKEN);
  Modular.to.pushReplacementNamed('/login');
}

Map<String, dynamic> handlerError(Object error) {
  if (error is DioException) {
    DioException dioError = error;
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return {'code': 501, 'message': "Request to API server was cancelled"};
      case DioExceptionType.connectionTimeout:
        return {'code': 502, 'message': "Connection timeout with API server"};
      case DioExceptionType.unknown:
        return {
          'code': 503,
          'message':
              "Connection to API server failed due to internet connection",
        };
      case DioExceptionType.receiveTimeout:
        return {
          'code': 504,
          'message': "Receive timeout in connection with API server",
        };
      case DioExceptionType.badResponse:
        switch (dioError.response?.statusCode) {
          case 404:
            return {
              'code': dioError.response?.statusCode,
              'message': dioError.response?.statusMessage,
            };
          case 401:
            final msg = dioError.response?.data['message'] ?? "";
            if (msg.contains('token')) {
              doExpires();
            }
            return dioError.response?.data;
          default:
            return dioError.response?.data;
        }
      case DioExceptionType.sendTimeout:
        return {
          'code': 505,
          'message': "Send timeout in connection with API server",
        };
      case DioExceptionType.badCertificate:
        return {'code': 506, 'message': "Bad certificate"};
      case DioExceptionType.connectionError:
        return {'code': 507, 'message': "Connection error"};
    }
  }
  return {'code': 500, 'message': "Unexpected error occured"};
}
