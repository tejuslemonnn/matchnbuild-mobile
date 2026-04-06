import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_auth.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class TokenAuth {
  @HiveField(0)
  final String token;

  @HiveField(1)
  final String refreshToken;

  const TokenAuth({
    required this.token,
    required this.refreshToken,
  });

  factory TokenAuth.fromJson(Map<String, dynamic> json) =>
      _$TokenAuthFromJson(json);

  Map<String, dynamic> toJson() => _$TokenAuthToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenAuth &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          refreshToken == other.refreshToken;

  @override
  int get hashCode => token.hashCode ^ refreshToken.hashCode;
}
