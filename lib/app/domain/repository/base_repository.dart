import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:mnb_mobile/services/api_result.dart';
import 'package:mnb_mobile/services/error/failure.dart';

abstract class BaseRepository {
  Either<Failure, T> parseResult<T>(ApiResult<T> result) {
    try {
      if (result is Success<T>) {
        if (kDebugMode) {
          print("Success: ${result.data}");
        }
        return Right(result.data);
      }

      if (result is Failed<T>) {
        if (kDebugMode) {
          print(result.errors);
        }
        return Left(ApiFailure(error: result.errors.message));
      }

      if (kDebugMode) {
        print("Unknown error occurred");
      }

      return Left(ConnectionFailure());
    } catch (e) {
      rethrow;
    }
  }
}
