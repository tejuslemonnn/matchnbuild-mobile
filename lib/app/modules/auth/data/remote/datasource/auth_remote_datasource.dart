import 'package:mnb_mobile/app/modules/auth/data/local/model/token_auth/token_auth.dart';
import 'package:mnb_mobile/services/api.dart';

abstract class AuthRemoteDatasource {
  Future<TokenAuth> login(String email, String password);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final DioClient _dioClient;

  AuthRemoteDatasourceImpl(this._dioClient);

  @override
  Future<TokenAuth> login(String email, String password) async {
    final response = await _dioClient.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    final body = response.data as Map<String, dynamic>;
    final data = body['data'] as Map<String, dynamic>;

    return TokenAuth(
      token: data['access_token'] as String,
      refreshToken: data['refresh_token'] as String,
    );
  }
}
