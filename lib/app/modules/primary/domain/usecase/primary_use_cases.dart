import 'package:dartz/dartz.dart';
import 'package:mnb_mobile/app/modules/primary/data/datasource/primary_remote_datasource.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/design_item_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/designer_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/feature_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/preference_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/project_request_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/quotation_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/user_model.dart';
import 'package:mnb_mobile/app/modules/primary/domain/repository/primary_repository.dart';
import 'package:mnb_mobile/services/error/failure.dart';
import 'package:mnb_mobile/services/use_case/base_use_case.dart';

// ── Designers ─────────────────────────────────────────────────────────

class GetDesignersUseCase extends BaseUseCase<List<DesignerModel>> {
  final PrimaryRepository _repository;
  GetDesignersUseCase(this._repository);

  @override
  Future<Either<Failure, List<DesignerModel>>> call() =>
      _repository.getDesigners();
}

class GetDesignerByIdUseCase extends BaseUseCaseParam<DesignerModel, String> {
  final PrimaryRepository _repository;
  GetDesignerByIdUseCase(this._repository);

  @override
  Future<Either<Failure, DesignerModel>> call(String id) =>
      _repository.getDesignerById(id);
}

// ── Design items ──────────────────────────────────────────────────────

class GetDesignItemsUseCase extends BaseUseCase<List<DesignItemModel>> {
  final PrimaryRepository _repository;
  GetDesignItemsUseCase(this._repository);

  @override
  Future<Either<Failure, List<DesignItemModel>>> call() =>
      _repository.getDesignItems();
}

class GetDesignItemByIdUseCase
    extends BaseUseCaseParam<DesignItemModel, String> {
  final PrimaryRepository _repository;
  GetDesignItemByIdUseCase(this._repository);

  @override
  Future<Either<Failure, DesignItemModel>> call(String id) =>
      _repository.getDesignItemById(id);
}

class GetRecommendationsUseCase extends BaseUseCase<RecommendationResult> {
  final PrimaryRepository _repository;
  GetRecommendationsUseCase(this._repository);

  @override
  Future<Either<Failure, RecommendationResult>> call() =>
      _repository.getRecommendations();
}

// ── Features ──────────────────────────────────────────────────────────

class GetFeaturesUseCase extends BaseUseCase<List<FeatureModel>> {
  final PrimaryRepository _repository;
  GetFeaturesUseCase(this._repository);

  @override
  Future<Either<Failure, List<FeatureModel>>> call() =>
      _repository.getFeatures();
}

// ── User ──────────────────────────────────────────────────────────────

class GetCurrentUserUseCase extends BaseUseCase<UserModel> {
  final PrimaryRepository _repository;
  GetCurrentUserUseCase(this._repository);

  @override
  Future<Either<Failure, UserModel>> call() => _repository.getCurrentUser();
}

class UpdateUserUseCase extends BaseUseCaseParam<UserModel, UpdateUserParams> {
  final PrimaryRepository _repository;
  UpdateUserUseCase(this._repository);

  @override
  Future<Either<Failure, UserModel>> call(UpdateUserParams param) =>
      _repository.updateUser(param.id, param.request);
}

class UpdateUserParams {
  final String id;
  final UpdateUserRequest request;

  const UpdateUserParams({required this.id, required this.request});
}

// ── User preferences ──────────────────────────────────────────────────

class GetMyPreferencesUseCase extends BaseUseCase<PreferenceModel?> {
  final PrimaryRepository _repository;
  GetMyPreferencesUseCase(this._repository);

  @override
  Future<Either<Failure, PreferenceModel?>> call() =>
      _repository.getMyPreferences();
}

class CreatePreferencesUseCase
    extends BaseUseCaseParam<PreferenceModel, CreatePreferenceRequest> {
  final PrimaryRepository _repository;
  CreatePreferencesUseCase(this._repository);

  @override
  Future<Either<Failure, PreferenceModel>> call(
    CreatePreferenceRequest param,
  ) =>
      _repository.createPreferences(param);
}

class UpdatePreferencesUseCase
    extends BaseUseCaseParam<PreferenceModel, UpdatePreferenceRequest> {
  final PrimaryRepository _repository;
  UpdatePreferencesUseCase(this._repository);

  @override
  Future<Either<Failure, PreferenceModel>> call(
    UpdatePreferenceRequest param,
  ) =>
      _repository.updatePreferences(param);
}

// ── Project request ───────────────────────────────────────────────────

class GetMyRequestsUseCase extends BaseUseCase<List<ProjectRequestModel>> {
  final PrimaryRepository _repository;
  GetMyRequestsUseCase(this._repository);

  @override
  Future<Either<Failure, List<ProjectRequestModel>>> call() =>
      _repository.getMyRequests();
}

class GetProjectRequestByIdUseCase
    extends BaseUseCaseParam<ProjectRequestModel, String> {
  final PrimaryRepository _repository;
  GetProjectRequestByIdUseCase(this._repository);

  @override
  Future<Either<Failure, ProjectRequestModel>> call(String id) =>
      _repository.getProjectRequestById(id);
}

class CreateProjectRequestUseCase
    extends BaseUseCaseParam<ProjectRequestModel, CreateProjectRequest> {
  final PrimaryRepository _repository;
  CreateProjectRequestUseCase(this._repository);

  @override
  Future<Either<Failure, ProjectRequestModel>> call(
    CreateProjectRequest param,
  ) =>
      _repository.createProjectRequest(param);
}

// ── Quotation ─────────────────────────────────────────────────────────

class GetQuotationByIdUseCase
    extends BaseUseCaseParam<QuotationModel, String> {
  final PrimaryRepository _repository;
  GetQuotationByIdUseCase(this._repository);

  @override
  Future<Either<Failure, QuotationModel>> call(String id) =>
      _repository.getQuotationById(id);
}

class AcceptQuotationUseCase
    extends BaseUseCaseParam<QuotationAcceptModel, String> {
  final PrimaryRepository _repository;
  AcceptQuotationUseCase(this._repository);

  @override
  Future<Either<Failure, QuotationAcceptModel>> call(String id) =>
      _repository.acceptQuotation(id);
}

class RejectQuotationUseCase extends BaseUseCaseParam<void, String> {
  final PrimaryRepository _repository;
  RejectQuotationUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(String id) =>
      _repository.rejectQuotation(id);
}
