import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String getError() {
    if (this is ApiFailure) {
      return (this as ApiFailure).error;
    }

    if (this is ConnectionFailure) {
      return "Connection error";
    }

    return "Something went wrong!";
  }
}

class EmptyFailure extends Failure {
  @override
  List<Object> get props => [];
}

class ConnectionFailure extends Failure {
  @override
  List<Object> get props => [];
}

class ApiFailure extends Failure {
  final String error;
  final String? code;

  @override
  List<Object?> get props => [error, code];

  ApiFailure({required this.error, this.code});
}
