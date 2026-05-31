import 'package:equatable/equatable.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/json_parse.dart';

/// Mirrors `UserResponse` (§4.2 of api.md).
class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? profilePicture;
  final bool isVerified;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.profilePicture,
    this.isVerified = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: asString(json['id']),
      name: asString(json['name']),
      email: asString(json['email']),
      role: asString(json['role']),
      profilePicture: asStringOrNull(json['profile_picture']),
      isVerified: asBool(json['is_verified']),
    );
  }

  @override
  List<Object?> get props => [id, name, email, role, profilePicture, isVerified];
}
