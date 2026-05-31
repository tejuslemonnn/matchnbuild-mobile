import 'package:equatable/equatable.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/feature_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/json_parse.dart';

/// Mirrors `DesignItemResponse` (§6 of api.md).
///
/// The backend response is not fully enumerated in the docs, so parsing is
/// defensive: every field is optional and tolerates either snake_case keys or
/// nested objects (e.g. `designer`).
class DesignItemModel extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? style;
  final String? category;
  final double? landAreaMin;
  final double? landAreaMax;
  final double? buildingArea;
  final int? numFloors;
  final int? numBedrooms;
  final String? roomType;
  final double? roomArea;
  final double? estimatedBudget;
  final double? priceStartFrom;
  final String? imageUrl;
  final String? location;
  final String? designerId;
  final String? designerName;
  final List<FeatureModel> features;

  const DesignItemModel({
    required this.id,
    required this.title,
    this.description,
    this.style,
    this.category,
    this.landAreaMin,
    this.landAreaMax,
    this.buildingArea,
    this.numFloors,
    this.numBedrooms,
    this.roomType,
    this.roomArea,
    this.estimatedBudget,
    this.priceStartFrom,
    this.imageUrl,
    this.location,
    this.designerId,
    this.designerName,
    this.features = const [],
  });

  factory DesignItemModel.fromJson(Map<String, dynamic> json) {
    final designer = json['designer'];
    String? designerName;
    String? designerId = asStringOrNull(json['designer_id']);
    if (designer is Map<String, dynamic>) {
      designerName = asStringOrNull(designer['name']);
      designerId ??= asStringOrNull(designer['id']);
    }
    designerName ??= asStringOrNull(json['designer_name']);

    final rawFeatures = json['features'];
    final features = <FeatureModel>[];
    if (rawFeatures is List) {
      for (final f in rawFeatures) {
        if (f is Map<String, dynamic>) {
          features.add(FeatureModel.fromJson(f));
        }
      }
    }

    return DesignItemModel(
      id: asString(json['id']),
      title: asString(json['title']),
      description: asStringOrNull(json['description']),
      style: asStringOrNull(json['style']),
      category: asStringOrNull(json['category']),
      landAreaMin: asDoubleOrNull(json['land_area_min']),
      landAreaMax: asDoubleOrNull(json['land_area_max']),
      buildingArea: asDoubleOrNull(json['building_area']),
      numFloors: asIntOrNull(json['num_floors']),
      numBedrooms: asIntOrNull(json['num_bedrooms']),
      roomType: asStringOrNull(json['room_type']),
      roomArea: asDoubleOrNull(json['room_area']),
      estimatedBudget: asDoubleOrNull(json['estimated_budget']),
      priceStartFrom: asDoubleOrNull(json['price_start_from']),
      imageUrl: asStringOrNull(json['image_url']),
      location: asStringOrNull(json['location']),
      designerId: designerId,
      designerName: designerName,
      features: features,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        style,
        category,
        landAreaMin,
        landAreaMax,
        buildingArea,
        numFloors,
        numBedrooms,
        roomType,
        roomArea,
        estimatedBudget,
        priceStartFrom,
        imageUrl,
        location,
        designerId,
        designerName,
        features,
      ];
}
