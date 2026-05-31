import 'package:equatable/equatable.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/json_parse.dart';

/// Mirrors `PreferenceResponse` (§8.3 of api.md). Note the backend serialises
/// `budget_min` / `budget_max` as strings.
class PreferenceModel extends Equatable {
  final String id;
  final String? preferredStyle;
  final double? budgetMin;
  final double? budgetMax;
  final String? preferredLocation;
  final bool isOnboarded;

  const PreferenceModel({
    required this.id,
    this.preferredStyle,
    this.budgetMin,
    this.budgetMax,
    this.preferredLocation,
    this.isOnboarded = false,
  });

  factory PreferenceModel.fromJson(Map<String, dynamic> json) {
    return PreferenceModel(
      id: asString(json['id']),
      preferredStyle: asStringOrNull(json['preferred_style']),
      budgetMin: asDoubleOrNull(json['budget_min']),
      budgetMax: asDoubleOrNull(json['budget_max']),
      preferredLocation: asStringOrNull(json['preferred_location']),
      isOnboarded: asBool(json['is_onboarded']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        preferredStyle,
        budgetMin,
        budgetMax,
        preferredLocation,
        isOnboarded,
      ];
}
