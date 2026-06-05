import 'package:dio/dio.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/design_item_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/designer_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/feature_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/preference_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/project_request_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/quotation_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/user_model.dart';
import 'package:mnb_mobile/services/api.dart';

/// Result of `GET /design-items/recommendations` (§6.3).
class RecommendationResult {
  final List<DesignItemModel> items;
  final String matchType;

  const RecommendationResult({required this.items, this.matchType = ''});
}

/// Single remote datasource for every endpoint consumed by the primary module.
abstract class PrimaryRemoteDatasource {
  // Designers
  Future<List<DesignerModel>> getDesigners();
  Future<DesignerModel> getDesignerById(String id);

  // Design items
  Future<List<DesignItemModel>> getDesignItems();
  Future<DesignItemModel> getDesignItemById(String id);
  Future<RecommendationResult> getRecommendations();

  // Features
  Future<List<FeatureModel>> getFeatures();

  // User
  Future<UserModel> getCurrentUser();
  Future<UserModel> updateUser(String id, UpdateUserRequest request);

  // User preferences
  Future<PreferenceModel?> getMyPreferences();
  Future<PreferenceModel> createPreferences(CreatePreferenceRequest request);
  Future<PreferenceModel> updatePreferences(UpdatePreferenceRequest request);

  // Project request
  Future<List<ProjectRequestModel>> getMyRequests();
  Future<ProjectRequestModel> getProjectRequestById(String id);
  Future<ProjectRequestModel> createProjectRequest(
    CreateProjectRequest request,
  );

  // Quotation
  Future<QuotationModel> getQuotationById(String id);
  Future<QuotationAcceptModel> acceptQuotation(String id);
  Future<void> rejectQuotation(String id);
}

class PrimaryRemoteDatasourceImpl implements PrimaryRemoteDatasource {
  final DioClient _client;

  PrimaryRemoteDatasourceImpl(this._client);

  // ── Response helpers ──────────────────────────────────────────────

  Map<String, dynamic> _object(Response response) {
    final body = response.data;
    if (body is Map<String, dynamic>) {
      final data = body['data'];
      if (data is Map<String, dynamic>) return data;
    }
    return <String, dynamic>{};
  }

  List<dynamic> _list(Response response) {
    final body = response.data;
    if (body is Map<String, dynamic>) {
      final data = body['data'];
      if (data is List) return data;
      if (data is Map<String, dynamic> && data['items'] is List) {
        return data['items'] as List;
      }
    }
    return const [];
  }

  List<T> _mapList<T>(Response response, T Function(Map<String, dynamic>) mapper) {
    return _list(response)
        .whereType<Map<String, dynamic>>()
        .map(mapper)
        .toList();
  }

  // ── Designers ─────────────────────────────────────────────────────

  @override
  Future<List<DesignerModel>> getDesigners() async {
    final response = await _client.get('/designers');
    return _mapList(response, DesignerModel.fromJson);
  }

  @override
  Future<DesignerModel> getDesignerById(String id) async {
    final response = await _client.get('/designers/$id');
    return DesignerModel.fromJson(_object(response));
  }

  // ── Design items ──────────────────────────────────────────────────

  @override
  Future<List<DesignItemModel>> getDesignItems() async {
    final response = await _client.get('/design-items');
    return _mapList(response, DesignItemModel.fromJson);
  }

  @override
  Future<DesignItemModel> getDesignItemById(String id) async {
    final response = await _client.get('/design-items/$id');
    return DesignItemModel.fromJson(_object(response));
  }

  @override
  Future<RecommendationResult> getRecommendations() async {
    final response = await _client.get('/design-items/recommendations');
    final data = _object(response);
    final rawItems = data['items'];
    final items = <DesignItemModel>[];
    if (rawItems is List) {
      for (final item in rawItems) {
        if (item is Map<String, dynamic>) {
          items.add(DesignItemModel.fromJson(item));
        }
      }
    }
    return RecommendationResult(
      items: items,
      matchType: (data['match_type'] ?? '').toString(),
    );
  }

  // ── Features ──────────────────────────────────────────────────────

  @override
  Future<List<FeatureModel>> getFeatures() async {
    final response = await _client.get('/features');
    return _mapList(response, FeatureModel.fromJson);
  }

  // ── User ──────────────────────────────────────────────────────────

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await _client.get('/user/me');
    return UserModel.fromJson(_object(response));
  }

  @override
  Future<UserModel> updateUser(String id, UpdateUserRequest request) async {
    final response = await _client.patch('/user/$id', data: request.toJson());
    return UserModel.fromJson(_object(response));
  }

  // ── User preferences ──────────────────────────────────────────────

  @override
  Future<PreferenceModel?> getMyPreferences() async {
    final response = await _client.get('/user-preferences/me');
    final data = _object(response);
    if (data.isEmpty) return null;
    return PreferenceModel.fromJson(data);
  }

  @override
  Future<PreferenceModel> createPreferences(
    CreatePreferenceRequest request,
  ) async {
    final response = await _client.post(
      '/user-preferences',
      data: request.toJson(),
    );
    return PreferenceModel.fromJson(_object(response));
  }

  @override
  Future<PreferenceModel> updatePreferences(
    UpdatePreferenceRequest request,
  ) async {
    final response = await _client.patch(
      '/user-preferences/me',
      data: request.toJson(),
    );
    return PreferenceModel.fromJson(_object(response));
  }

  // ── Project request ───────────────────────────────────────────────

  @override
  Future<List<ProjectRequestModel>> getMyRequests() async {
    final response = await _client.get('/project-request/my-requests');
    return _mapList(response, ProjectRequestModel.fromJson);
  }

  @override
  Future<ProjectRequestModel> getProjectRequestById(String id) async {
    final response = await _client.get('/project-request/$id');
    return ProjectRequestModel.fromJson(_object(response));
  }

  @override
  Future<ProjectRequestModel> createProjectRequest(
    CreateProjectRequest request,
  ) async {
    final response = await _client.post(
      '/project-request',
      data: request.toJson(),
    );
    return ProjectRequestModel.fromJson(_object(response));
  }

  // ── Quotation ─────────────────────────────────────────────────────

  @override
  Future<QuotationModel> getQuotationById(String id) async {
    final response = await _client.get('/quotation/$id');
    return QuotationModel.fromJson(_object(response));
  }

  @override
  Future<QuotationAcceptModel> acceptQuotation(String id) async {
    final response = await _client.put('/quotation/$id/accept');
    return QuotationAcceptModel.fromJson(_object(response));
  }

  @override
  Future<void> rejectQuotation(String id) async {
    await _client.put('/quotation/$id/reject');
  }
}

// ── Request payloads ──────────────────────────────────────────────────

/// Body for `POST /project-request` (§9.1).
class CreateProjectRequest {
  final String designerId;
  final String description;
  final double initialBudget;
  final double areaSize;
  final String? locationPhotoUrl;
  final String? layoutSketchUrl;

  const CreateProjectRequest({
    required this.designerId,
    required this.description,
    required this.initialBudget,
    required this.areaSize,
    this.locationPhotoUrl,
    this.layoutSketchUrl,
  });

  Map<String, dynamic> toJson() => {
        'designer_id': designerId,
        'description': description,
        'initial_budget': initialBudget,
        'area_size': areaSize,
        if (locationPhotoUrl != null) 'location_photo_url': locationPhotoUrl,
        if (layoutSketchUrl != null) 'layout_sketch_url': layoutSketchUrl,
      };
}

/// Body for `PATCH /user/:id` (§4.3). All fields optional.
class UpdateUserRequest {
  final String? name;
  final String? email;
  final String? profilePicture;

  const UpdateUserRequest({this.name, this.email, this.profilePicture});

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
        if (email != null) 'email': email,
        if (profilePicture != null) 'profile_picture': profilePicture,
      };
}

/// Body for `POST /user-preferences` (§8.2). All fields required.
class CreatePreferenceRequest {
  final String preferredStyle;
  final double budgetMin;
  final double budgetMax;
  final String preferredLocation;

  const CreatePreferenceRequest({
    required this.preferredStyle,
    required this.budgetMin,
    required this.budgetMax,
    required this.preferredLocation,
  });

  Map<String, dynamic> toJson() => {
        'preferred_style': preferredStyle,
        'budget_min': budgetMin,
        'budget_max': budgetMax,
        'preferred_location': preferredLocation,
      };
}

/// Body for `PATCH /user-preferences/me` (§8.3). All fields optional.
class UpdatePreferenceRequest {
  final String? preferredStyle;
  final double? budgetMin;
  final double? budgetMax;
  final String? preferredLocation;

  const UpdatePreferenceRequest({
    this.preferredStyle,
    this.budgetMin,
    this.budgetMax,
    this.preferredLocation,
  });

  Map<String, dynamic> toJson() => {
        if (preferredStyle != null) 'preferred_style': preferredStyle,
        if (budgetMin != null) 'budget_min': budgetMin,
        if (budgetMax != null) 'budget_max': budgetMax,
        if (preferredLocation != null) 'preferred_location': preferredLocation,
      };
}
