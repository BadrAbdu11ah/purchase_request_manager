class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'http://192.168.1.4:8000/api';

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String me = '/auth/me';
  static const String logout = '/auth/logout';

  static const String products = '/products';
  static const String categories = '/categories';
  static const String orders = '/orders';
  static const String dashboard = '/dashboard';

  static String productById(int id) => '/products/show/$id';
  static String productUpdate(int id) => '/products/update/$id';
  static String productDelete(int id) => '/products/delete/$id';
  static const String productStore = '/products/store';

  static String categoryById(int id) => '/categories/show/$id';
  static String categoryUpdate(int id) => '/categories/update/$id';
  static String categoryDelete(int id) => '/categories/delete/$id';
  static const String categoryStore = '/categories/store';

  static String orderById(int id) => '/orders/show/$id';
  static String updateOrderStatus(int id) => '/orders/update-status/$id';
  static const String storeOrder = '/orders/store';
  static String orderDelete(int id) => '/orders/delete/$id';
}
