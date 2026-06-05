import 'package:dartz/dartz.dart';
import 'package:mnb_mobile/app/domain/repository/base_repository.dart';
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

class PrimaryRepositoryImpl extends BaseRepository implements PrimaryRepository {
  final PrimaryRemoteDatasource _remoteDatasource;

  PrimaryRepositoryImpl(this._remoteDatasource);

  /// Wraps a remote call, converting any thrown exception into an [ApiFailure].
  Future<Either<Failure, T>> _guard<T>(Future<T> Function() call) async {
    try {
      return Right(await call());
    } catch (e) {
      return Left(ApiFailure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DesignerModel>>> getDesigners() =>
      _guard(_remoteDatasource.getDesigners);

  @override
  Future<Either<Failure, DesignerModel>> getDesignerById(String id) =>
      _guard(() => _remoteDatasource.getDesignerById(id));

  @override
  Future<Either<Failure, List<DesignItemModel>>> getDesignItems() =>
      _guard(_remoteDatasource.getDesignItems);

  @override
  Future<Either<Failure, DesignItemModel>> getDesignItemById(String id) =>
      _guard(() => _remoteDatasource.getDesignItemById(id));

  @override
  Future<Either<Failure, RecommendationResult>> getRecommendations() =>
      _guard(_remoteDatasource.getRecommendations);

  @override
  Future<Either<Failure, List<FeatureModel>>> getFeatures() =>
      _guard(_remoteDatasource.getFeatures);

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() =>
      _guard(_remoteDatasource.getCurrentUser);

  @override
  Future<Either<Failure, UserModel>> updateUser(
    String id,
    UpdateUserRequest request,
  ) =>
      _guard(() => _remoteDatasource.updateUser(id, request));

  @override
  Future<Either<Failure, PreferenceModel?>> getMyPreferences() =>
      _guard(_remoteDatasource.getMyPreferences);

  @override
  Future<Either<Failure, PreferenceModel>> createPreferences(
    CreatePreferenceRequest request,
  ) =>
      _guard(() => _remoteDatasource.createPreferences(request));

  @override
  Future<Either<Failure, PreferenceModel>> updatePreferences(
    UpdatePreferenceRequest request,
  ) =>
      _guard(() => _remoteDatasource.updatePreferences(request));

  @override
  Future<Either<Failure, List<ProjectRequestModel>>> getMyRequests() =>
      _guard(_remoteDatasource.getMyRequests);

  @override
  Future<Either<Failure, ProjectRequestModel>> getProjectRequestById(
    String id,
  ) =>
      _guard(() => _remoteDatasource.getProjectRequestById(id));

  @override
  Future<Either<Failure, ProjectRequestModel>> createProjectRequest(
    CreateProjectRequest request,
  ) =>
      _guard(() => _remoteDatasource.createProjectRequest(request));

  @override
  Future<Either<Failure, QuotationModel>> getQuotationById(String id) =>
      _guard(() => _remoteDatasource.getQuotationById(id));

  @override
  Future<Either<Failure, QuotationAcceptModel>> acceptQuotation(String id) =>
      _guard(() => _remoteDatasource.acceptQuotation(id));

  @override
  Future<Either<Failure, void>> rejectQuotation(String id) =>
      _guard(() => _remoteDatasource.rejectQuotation(id));
}
