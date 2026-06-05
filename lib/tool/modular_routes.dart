class ModularRoutes {
  // auth
  static const auth = '/auth/';
  static const authRegister = '/auth/register';
  static const authChooseRole = '/auth/choose-role';
  static const authStylePreferences = '/auth/style-preferences';

  // primary
  static const primary = '/primary';
  static const primaryEditProfile = '/primary/edit-profile';
  static const primaryDesignerDetail = '/primary/designer-detail';
  static const primaryDesignDetail = '/primary/design-detail';
  static const primaryMessageDetail = '/primary/message-detail';
  static const primaryPriceRequest = '/primary/price-request';
  static const primaryQuoteSummary = '/primary/quote-summary';
  static const primaryOrderReview = '/primary/order-review';
  static const primaryPaymentMethod = '/primary/payment-method';
  static const primaryPaymentSuccess = '/primary/payment-success';

  static String path(String routes) {
    return '/${routes.split('/').last}';
  }
}
