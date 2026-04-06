import 'package:flutter_modular/flutter_modular.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/home_page.dart';

class PrimaryModule extends Module {
  @override
  void binds(Injector i) {
    // TODO: Add binds here
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => const HomePage());
  }
}
