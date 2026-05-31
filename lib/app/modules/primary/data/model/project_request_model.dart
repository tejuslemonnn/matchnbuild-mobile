import 'package:equatable/equatable.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/json_parse.dart';

/// Mirrors `ProjectRequestResponse` (§9.4 of api.md).
class ProjectRequestModel extends Equatable {
  final String id;
  final String clientId;
  final String designerId;
  final String? description;
  final double initialBudget;
  final double areaSize;
  final String? locationPhotoUrl;
  final String? layoutSketchUrl;
  final String status;
  final String? conversationId;

  const ProjectRequestModel({
    required this.id,
    required this.clientId,
    required this.designerId,
    this.description,
    this.initialBudget = 0,
    this.areaSize = 0,
    this.locationPhotoUrl,
    this.layoutSketchUrl,
    this.status = 'open',
    this.conversationId,
  });

  factory ProjectRequestModel.fromJson(Map<String, dynamic> json) {
    return ProjectRequestModel(
      id: asString(json['id']),
      clientId: asString(json['client_id']),
      designerId: asString(json['designer_id']),
      description: asStringOrNull(json['description']),
      initialBudget: asDouble(json['initial_budget']),
      areaSize: asDouble(json['area_size']),
      locationPhotoUrl: asStringOrNull(json['location_photo_url']),
      layoutSketchUrl: asStringOrNull(json['layout_sketch_url']),
      status: asString(json['status'], fallback: 'open'),
      conversationId: asStringOrNull(json['conversation_id']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        clientId,
        designerId,
        description,
        initialBudget,
        areaSize,
        locationPhotoUrl,
        layoutSketchUrl,
        status,
        conversationId,
      ];
}
