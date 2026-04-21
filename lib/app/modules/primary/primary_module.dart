import 'package:flutter_modular/flutter_modular.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/design_detail_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/designer_detail_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/home_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/message_detail_page.dart';
import 'package:mnb_mobile/tool/modular_routes.dart';

class PrimaryModule extends Module {
  @override
  void binds(Injector i) {
    // TODO: Add binds here
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => const HomePage());
    r.child(
      ModularRoutes.path(ModularRoutes.primaryDesignerDetail),
      child: (context) => const DesignerDetailPage(),
    );
    r.child(
      ModularRoutes.path(ModularRoutes.primaryDesignDetail),
      child: (context) => const DesignDetailPage(),
    );
    r.child(
      ModularRoutes.path(ModularRoutes.primaryMessageDetail),
      child: (context) => const MessageDetailPage(),
    );
  }
}
