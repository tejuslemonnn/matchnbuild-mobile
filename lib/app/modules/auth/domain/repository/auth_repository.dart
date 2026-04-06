import 'package:dartz/dartz.dart';
import 'package:mnb_mobile/app/modules/auth/data/local/model/token_auth/token_auth.dart';
import 'package:mnb_mobile/services/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, TokenAuth>> login(String email, String password);
  Future<Either<Failure, void>> logout();
  Future<TokenAuth?> getToken();
  Future<bool> isLoggedIn();
}
