import 'package:equatable/equatable.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/json_parse.dart';

/// Mirrors `DesignerProfileResponse` (§5.4 of api.md).
class DesignerModel extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String? profilePicture;
  final String? bio;
  final int experienceYears;
  final bool isVerified;
  final bool isAvailable;
  final String? location;

  const DesignerModel({
    required this.id,
    required this.userId,
    required this.name,
    this.profilePicture,
    this.bio,
    this.experienceYears = 0,
    this.isVerified = false,
    this.isAvailable = false,
    this.location,
  });

  factory DesignerModel.fromJson(Map<String, dynamic> json) {
    return DesignerModel(
      id: asString(json['id']),
      userId: asString(json['user_id']),
      name: asString(json['name']),
      profilePicture: asStringOrNull(json['profile_picture']),
      bio: asStringOrNull(json['bio']),
      experienceYears: asInt(json['experience_years']),
      isVerified: asBool(json['is_verified']),
      isAvailable: asBool(json['is_available']),
      location: asStringOrNull(json['location']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        profilePicture,
        bio,
        experienceYears,
        isVerified,
        isAvailable,
        location,
      ];
}
