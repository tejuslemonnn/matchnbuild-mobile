import 'package:equatable/equatable.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/json_parse.dart';

/// Mirrors `FeatureResponse` (§7.1 of api.md).
class FeatureModel extends Equatable {
  final String id;
  final String name;

  const FeatureModel({required this.id, required this.name});

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      id: asString(json['id']),
      name: asString(json['name']),
    );
  }

  @override
  List<Object?> get props => [id, name];
}
