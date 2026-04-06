import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mnb_mobile/app/modules/auth/data/local/model/token_auth/token_auth.dart';
import 'package:mnb_mobile/app/modules/auth/domain/repository/auth_repository.dart';
import 'package:mnb_mobile/services/error/failure.dart';
import 'package:mnb_mobile/services/use_case/base_use_case.dart';

class LoginUseCase extends BaseUseCaseParam<TokenAuth, LoginParams> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, TokenAuth>> call(LoginParams param) {
    return _repository.login(param.email, param.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
