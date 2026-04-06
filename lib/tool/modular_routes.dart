class ModularRoutes {
  // auth
  static const auth = '/auth/';
  static const authRegister = '/auth/register';

  // primary
  static const primary = '/primary';

  static String path(String routes) {
    return '/${routes.split('/').last}';
  }
}
