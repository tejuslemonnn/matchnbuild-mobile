import 'package:flutter_modular/flutter_modular.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/design_detail_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/designer_detail_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/home_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/message_detail_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/order_review_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/payment_method_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/payment_success_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/price_request_page.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/quote_summary_page.dart';
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
    r.child(
      ModularRoutes.path(ModularRoutes.primaryPriceRequest),
      child: (context) => const PriceRequestPage(),
    );
    r.child(
      ModularRoutes.path(ModularRoutes.primaryQuoteSummary),
      child: (context) => const QuoteSummaryPage(),
    );
    r.child(
      ModularRoutes.path(ModularRoutes.primaryOrderReview),
      child: (context) => const OrderReviewPage(),
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
