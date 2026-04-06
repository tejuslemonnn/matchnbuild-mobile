import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

abstract class BaseUseCaseParam<T, P> {
  Future<Either<Failure, T>> call(P param);
}

abstract class BaseUseCase<T> {
  Future<Either<Failure, T>> call();
}

class DefaultParams extends Equatable {
  const DefaultParams();
  @override
  List<Object> get props => [];
}
