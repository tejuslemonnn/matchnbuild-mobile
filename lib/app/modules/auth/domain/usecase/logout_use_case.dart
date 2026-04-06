import 'package:dartz/dartz.dart';
import 'package:mnb_mobile/app/modules/auth/domain/repository/auth_repository.dart';
import 'package:mnb_mobile/services/error/failure.dart';
import 'package:mnb_mobile/services/use_case/base_use_case.dart';

class LogoutUseCase extends BaseUseCase<void> {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call() {
    return _repository.logout();
  }
}
