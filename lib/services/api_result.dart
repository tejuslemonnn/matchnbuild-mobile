import 'package:dio/dio.dart';
import 'package:mnb_mobile/services/api_error.dart';

abstract class ApiResult<T> {
  static ApiResult<T> fromResponse<T>(
    Response response,
    T Function(Map<String, dynamic>) mapper,
  ) {
    final data = response.data;

    if (data != null && data is Map<String, dynamic>) {
      return Success(mapper(data));
    } else {
      return InternalError();
    }
  }
}

class Success<T> extends ApiResult<T> {
  final T data;

  Success(this.data);
}

class Failed<T> extends ApiResult<T> {
  ApiError errors;

  Failed(this.errors);
}

class ServerError<T> extends Failed<T> {
  ServerError(super.errors);

  static ServerError<T> fromDioException<T>(DioException e) {
    final data = e.response?.data;
    String message = e.message ?? 'Unknown error';
    String? code;

    if (data is Map<String, dynamic>) {
      message = data['message'] ?? message;
      code = data['code']?.toString();
    }

    return ServerError(
      ApiError(code: code, message: message),
    );
  }
}

class NetworkError<T> extends Failed<T> {
  NetworkError(super.errors);
}

class InternalError<T> extends Failed<T> {
  InternalError()
    : super(const ApiError(code: null, message: "Internal Error"));
}
