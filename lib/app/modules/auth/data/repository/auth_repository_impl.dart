import 'package:dartz/dartz.dart';
import 'package:mnb_mobile/app/domain/repository/base_repository.dart';
import 'package:mnb_mobile/app/modules/auth/data/local/datasource/auth_local_datasource.dart';
import 'package:mnb_mobile/app/modules/auth/data/local/model/token_auth/token_auth.dart';
import 'package:mnb_mobile/app/modules/auth/data/remote/datasource/auth_remote_datasource.dart';
import 'package:mnb_mobile/app/modules/auth/domain/repository/auth_repository.dart';
import 'package:mnb_mobile/services/api.dart';
import 'package:mnb_mobile/services/error/failure.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;
  final AuthLocalDatasource _localDatasource;
  final DioClient _dioClient;

  AuthRepositoryImpl(
    this._remoteDatasource,
    this._localDatasource,
    this._dioClient,
  );

  @override
  Future<Either<Failure, TokenAuth>> login(
    String email,
    String password,
  ) async {
    try {
      final tokenAuth = await _remoteDatasource.login(email, password);
      await _localDatasource.saveToken(tokenAuth);
      _dioClient.setAuthToken(tokenAuth.token);
      return Right(tokenAuth);
    } catch (e) {
      return Left(ApiFailure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _localDatasource.deleteToken();
      _dioClient.clearAuthToken();
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(error: e.toString()));
    }
  }

  @override
  Future<TokenAuth?> getToken() async {
    return _localDatasource.getToken();
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _localDatasource.getToken();
    return token != null;
  }
}
