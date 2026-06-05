import 'package:dartz/dartz.dart';
import 'package:mnb_mobile/app/modules/primary/data/datasource/primary_remote_datasource.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/design_item_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/designer_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/feature_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/preference_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/project_request_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/quotation_model.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/user_model.dart';
import 'package:mnb_mobile/services/error/failure.dart';

abstract class PrimaryRepository {
  Future<Either<Failure, List<DesignerModel>>> getDesigners();
  Future<Either<Failure, DesignerModel>> getDesignerById(String id);

  Future<Either<Failure, List<DesignItemModel>>> getDesignItems();
  Future<Either<Failure, DesignItemModel>> getDesignItemById(String id);
  Future<Either<Failure, RecommendationResult>> getRecommendations();

  Future<Either<Failure, List<FeatureModel>>> getFeatures();

  Future<Either<Failure, UserModel>> getCurrentUser();
  Future<Either<Failure, UserModel>> updateUser(
    String id,
    UpdateUserRequest request,
  );

  Future<Either<Failure, PreferenceModel?>> getMyPreferences();
  Future<Either<Failure, PreferenceModel>> createPreferences(
    CreatePreferenceRequest request,
  );
  Future<Either<Failure, PreferenceModel>> updatePreferences(
    UpdatePreferenceRequest request,
  );

  Future<Either<Failure, List<ProjectRequestModel>>> getMyRequests();
  Future<Either<Failure, ProjectRequestModel>> getProjectRequestById(String id);
  Future<Either<Failure, ProjectRequestModel>> createProjectRequest(
    CreateProjectRequest request,
  );

  Future<Either<Failure, QuotationModel>> getQuotationById(String id);
  Future<Either<Failure, QuotationAcceptModel>> acceptQuotation(String id);
  Future<Either<Failure, void>> rejectQuotation(String id);
}
