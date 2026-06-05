import 'package:flutter_modular/flutter_modular.dart';
import 'package:mnb_mobile/app/modules/primary/data/datasource/primary_remote_datasource.dart';
import 'package:mnb_mobile/app/modules/primary/data/repository/primary_repository_impl.dart';
import 'package:mnb_mobile/app/modules/primary/domain/repository/primary_repository.dart';
import 'package:mnb_mobile/app/modules/primary/domain/usecase/primary_use_cases.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/design_detail_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/design_items_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/designer_detail_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/home_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/preferences_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/profile_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/project_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/project_request_form_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/quotation_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/user_model.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/design_detail_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/designer_detail_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/edit_profile_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/home_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/message_detail_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/order_review_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/payment_method_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/payment_success_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/price_request_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/quote_summary_page.dart';
import 'package:mnb_mobile/services/api.dart';
import 'package:mnb_mobile/tool/modular_routes.dart';

class PrimaryModule extends Module {
  @override
  void binds(Injector i) {
    // Api (from parent module)
    i.add<DioClient>(() => Modular.get<DioClient>());

    // Data source
    i.add<PrimaryRemoteDatasource>(
      () => PrimaryRemoteDatasourceImpl(i.get<DioClient>()),
    );

    // Repository
    i.add<PrimaryRepository>(
      () => PrimaryRepositoryImpl(i.get<PrimaryRemoteDatasource>()),
    );

    // Use cases
    i.add(() => GetDesignersUseCase(i.get<PrimaryRepository>()));
    i.add(() => GetDesignerByIdUseCase(i.get<PrimaryRepository>()));
    i.add(() => GetDesignItemsUseCase(i.get<PrimaryRepository>()));
    i.add(() => GetDesignItemByIdUseCase(i.get<PrimaryRepository>()));
    i.add(() => GetRecommendationsUseCase(i.get<PrimaryRepository>()));
    i.add(() => GetFeaturesUseCase(i.get<PrimaryRepository>()));
    i.add(() => GetCurrentUserUseCase(i.get<PrimaryRepository>()));
    i.add(() => UpdateUserUseCase(i.get<PrimaryRepository>()));
    i.add(() => GetMyPreferencesUseCase(i.get<PrimaryRepository>()));
    i.add(() => CreatePreferencesUseCase(i.get<PrimaryRepository>()));
    i.add(() => UpdatePreferencesUseCase(i.get<PrimaryRepository>()));
    i.add(() => GetMyRequestsUseCase(i.get<PrimaryRepository>()));
    i.add(() => GetProjectRequestByIdUseCase(i.get<PrimaryRepository>()));
    i.add(() => CreateProjectRequestUseCase(i.get<PrimaryRepository>()));
    i.add(() => GetQuotationByIdUseCase(i.get<PrimaryRepository>()));
    i.add(() => AcceptQuotationUseCase(i.get<PrimaryRepository>()));
    i.add(() => RejectQuotationUseCase(i.get<PrimaryRepository>()));

    // Cubits
    i.add(() => HomeCubit(
          i.get<GetDesignersUseCase>(),
          i.get<GetDesignItemsUseCase>(),
        ));
    i.add(() => DesignItemsCubit(i.get<GetDesignItemsUseCase>()));
    i.add(() => DesignerDetailCubit(i.get<GetDesignerByIdUseCase>()));
    i.add(() => DesignDetailCubit(i.get<GetDesignItemByIdUseCase>()));
    i.add(() => ProjectCubit(i.get<GetMyRequestsUseCase>()));
    i.add(() => ProfileCubit(
          i.get<GetCurrentUserUseCase>(),
          i.get<UpdateUserUseCase>(),
        ));
    i.add(() => ProjectRequestFormCubit(i.get<CreateProjectRequestUseCase>()));
    i.add(() => QuotationCubit(
          i.get<GetQuotationByIdUseCase>(),
          i.get<AcceptQuotationUseCase>(),
          i.get<RejectQuotationUseCase>(),
        ));
    i.add(() => PreferencesCubit(
          i.get<GetMyPreferencesUseCase>(),
          i.get<CreatePreferencesUseCase>(),
          i.get<UpdatePreferencesUseCase>(),
        ));
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => const HomePage());
    r.child(
      ModularRoutes.path(ModularRoutes.primaryEditProfile),
      child: (context) => EditProfilePage(
        user: r.args.data is UserModel ? r.args.data as UserModel : null,
      ),
    );
    r.child(
      ModularRoutes.path(ModularRoutes.primaryDesignerDetail),
      child: (context) => DesignerDetailPage(
        designerId: r.args.data is String ? r.args.data as String : null,
      ),
    );
    r.child(
      ModularRoutes.path(ModularRoutes.primaryDesignDetail),
      child: (context) => DesignDetailPage(
        designItemId: r.args.data is String ? r.args.data as String : null,
      ),
    );
    r.child(
      ModularRoutes.path(ModularRoutes.primaryMessageDetail),
      child: (context) => const MessageDetailPage(),
    );
    r.child(
      ModularRoutes.path(ModularRoutes.primaryPriceRequest),
      child: (context) => PriceRequestPage(
        designerId: r.args.data is String ? r.args.data as String : null,
      ),
    );
    r.child(
      ModularRoutes.path(ModularRoutes.primaryQuoteSummary),
      child: (context) => QuoteSummaryPage(
        quotationId: r.args.data is String ? r.args.data as String : null,
      ),
    );
    r.child(
      ModularRoutes.path(ModularRoutes.primaryOrderReview),
      child: (context) => OrderReviewPage(
        quotationId: r.args.data is String ? r.args.data as String : null,
      ),
    );
    r.child(
      ModularRoutes.path(ModularRoutes.primaryPaymentMethod),
      child: (context) => const PaymentMethodPage(),
    );
    r.child(
      ModularRoutes.path(ModularRoutes.primaryPaymentSuccess),
      child: (context) => const PaymentSuccessPage(),
    );
  }
}
