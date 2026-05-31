import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mnb_mobile/app/modules/auth/domain/repository/auth_repository.dart';
import 'package:mnb_mobile/services/error/failure.dart';
import 'package:mnb_mobile/services/use_case/base_use_case.dart';

class RegisterUseCase extends BaseUseCaseParam<void, RegisterParams> {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(RegisterParams param) {
    return _repository.register(
      name: param.name,
      email: param.email,
      password: param.password,
      role: param.role,
    );
  }
}

class RegisterParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String role;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    this.role = 'client',
  });

  @override
  List<Object> get props => [name, email, password, role];
}
