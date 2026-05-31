import 'package:flutter_modular/flutter_modular.dart';
import 'package:mnb_mobile/app/modules/auth/data/local/datasource/auth_local_datasource.dart';
import 'package:mnb_mobile/app/modules/auth/data/remote/datasource/auth_remote_datasource.dart';
import 'package:mnb_mobile/app/modules/auth/data/repository/auth_repository_impl.dart';
import 'package:mnb_mobile/app/modules/auth/domain/repository/auth_repository.dart';
import 'package:mnb_mobile/app/modules/auth/domain/usecase/login_use_case.dart';
import 'package:mnb_mobile/app/modules/auth/domain/usecase/logout_use_case.dart';
import 'package:mnb_mobile/app/modules/auth/domain/usecase/register_use_case.dart';
import 'package:mnb_mobile/app/modules/auth/presentation/controller/auth_bloc.dart';
import 'package:mnb_mobile/app/modules/auth/presentation/pages/login_page.dart';
import 'package:mnb_mobile/app/modules/auth/presentation/pages/register_page.dart';
import 'package:mnb_mobile/app/modules/auth/presentation/pages/style_preferences_page.dart';
import 'package:mnb_mobile/app/modules/primary/data/datasource/primary_remote_datasource.dart';
import 'package:mnb_mobile/app/modules/primary/data/repository/primary_repository_impl.dart';
import 'package:mnb_mobile/app/modules/primary/domain/repository/primary_repository.dart';
import 'package:mnb_mobile/app/modules/primary/domain/usecase/primary_use_cases.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/preferences_cubit.dart';
import 'package:mnb_mobile/services/api.dart';
import 'package:mnb_mobile/tool/modular_routes.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    // Api (from parent module)
    i.add<DioClient>(() => Modular.get<DioClient>());

    // Data Sources
    i.add<AuthLocalDatasource>(() => Modular.get<AuthLocalDatasource>());
    i.add<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(i.get<DioClient>()),
    );

    // Repository
    i.add<AuthRepository>(
      () => AuthRepositoryImpl(
        i.get<AuthRemoteDatasource>(),
        i.get<AuthLocalDatasource>(),
        i.get<DioClient>(),
      ),
    );

    // Use Cases
    i.add<LoginUseCase>(() => LoginUseCase(i.get<AuthRepository>()));
    i.add<LogoutUseCase>(() => LogoutUseCase(i.get<AuthRepository>()));
    i.add<RegisterUseCase>(() => RegisterUseCase(i.get<AuthRepository>()));

    // Bloc/Controller
    i.addLazySingleton<AuthBloc>(
      () => AuthBloc(
        i.get<LoginUseCase>(),
        i.get<LogoutUseCase>(),
        i.get<RegisterUseCase>(),
      ),
    );

    // User preferences (used by the onboarding StylePreferencesPage). These
    // reuse the primary module's data layer over the shared DioClient.
    i.add<PrimaryRemoteDatasource>(
      () => PrimaryRemoteDatasourceImpl(i.get<DioClient>()),
    );
    i.add<PrimaryRepository>(
      () => PrimaryRepositoryImpl(i.get<PrimaryRemoteDatasource>()),
    );
    i.add(() => GetMyPreferencesUseCase(i.get<PrimaryRepository>()));
    i.add(() => CreatePreferencesUseCase(i.get<PrimaryRepository>()));
    i.add(() => UpdatePreferencesUseCase(i.get<PrimaryRepository>()));
    i.add(() => PreferencesCubit(
          i.get<GetMyPreferencesUseCase>(),
          i.get<CreatePreferencesUseCase>(),
          i.get<UpdatePreferencesUseCase>(),
        ));
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => const LoginPage());
    r.child(
      ModularRoutes.path(ModularRoutes.authRegister),
      child: (context) => const RegisterPage(),
    );
    r.child(
      ModularRoutes.path(ModularRoutes.authStylePreferences),
      child: (context) => const StylePreferencesPage(),
    );
  }
}
