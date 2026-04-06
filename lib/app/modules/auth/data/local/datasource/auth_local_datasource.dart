import 'package:hive/hive.dart';
import 'package:mnb_mobile/app/modules/auth/data/local/model/token_auth/token_auth.dart';

abstract class AuthLocalDatasource {
  Future<void> saveToken(TokenAuth token);
  Future<TokenAuth?> getToken();
  Future<void> deleteToken();
  bool hasToken();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  static const String _boxName = 'auth_box';
  static const String _tokenKey = 'token_auth';

  Future<Box<TokenAuth>> _getBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<TokenAuth>(_boxName);
    }
    return Hive.openBox<TokenAuth>(_boxName);
  }

  @override
  Future<void> saveToken(TokenAuth token) async {
    final box = await _getBox();
    await box.put(_tokenKey, token);
  }

  @override
  Future<TokenAuth?> getToken() async {
    final box = await _getBox();
    return box.get(_tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    final box = await _getBox();
    await box.delete(_tokenKey);
  }

  @override
  bool hasToken() {
    if (!Hive.isBoxOpen(_boxName)) return false;
    final box = Hive.box<TokenAuth>(_boxName);
    return box.containsKey(_tokenKey);
  }
}
