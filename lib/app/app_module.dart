import 'package:flutter_modular/flutter_modular.dart';
import 'package:mnb_mobile/app/controller/app_controller_bloc.dart';
import 'package:mnb_mobile/app/modules/auth/auth_module.dart';
import 'package:mnb_mobile/app/modules/auth/data/local/datasource/auth_local_datasource.dart';
import 'package:mnb_mobile/app/modules/primary/primary_module.dart';
import 'package:mnb_mobile/app/pages/splash/splash_screen.dart';
import 'package:mnb_mobile/services/api.dart';
import 'package:mnb_mobile/tool/modular_routes.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.add(DioClient.new);

    // Auth Local DataSource (needed for token management across app)
    i.addLazySingleton<AuthLocalDatasource>(AuthLocalDatasourceImpl.new);

    // App Controller
    i.addLazySingleton<AppControllerBloc>(
      () => AppControllerBloc(i.get<AuthLocalDatasource>(), i.get<DioClient>()),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => const SplashScreen());
    r.module(ModularRoutes.path(ModularRoutes.auth), module: AuthModule());
    r.module(
      ModularRoutes.path(ModularRoutes.primary),
      module: PrimaryModule(),
    );
  }
}
