import 'package:get/get.dart';
import 'package:purchase_request_manager/features/admin/categories/page/categories_binding.dart';
import 'package:purchase_request_manager/features/admin/categories/category_products/category_products_binding.dart';
import 'package:purchase_request_manager/features/admin/categories/add/add_category_binding.dart';
import 'package:purchase_request_manager/features/admin/categories/edit/edit_category_binding.dart';
import 'package:purchase_request_manager/constant/app_route.dart';
import 'package:purchase_request_manager/features/admin/categories/page/categories_page.dart';
import 'package:purchase_request_manager/features/admin/categories/category_products/category_products_page.dart';
import 'package:purchase_request_manager/features/admin/categories/add/add_category_page.dart';
import 'package:purchase_request_manager/features/admin/categories/edit/edit_category_page.dart';
import 'package:purchase_request_manager/features/admin/dashboard/dashboard_binding.dart';
import 'package:purchase_request_manager/features/admin/dashboard/dashboard_page.dart';
import 'package:purchase_request_manager/features/admin/orders/add/add_orders_binding.dart';
import 'package:purchase_request_manager/features/admin/orders/add/add_orders_page.dart';
import 'package:purchase_request_manager/features/admin/orders/details/order_details_binding.dart';
import 'package:purchase_request_manager/features/admin/orders/edit/edit_orders_binding.dart';
import 'package:purchase_request_manager/features/admin/orders/edit/edit_orders_page.dart';
import 'package:purchase_request_manager/features/admin/orders/page/orders_binding.dart';
import 'package:purchase_request_manager/features/admin/orders/details/order_details_page.dart';
import 'package:purchase_request_manager/features/admin/orders/page/orders_page.dart';
import 'package:purchase_request_manager/features/admin/products/add/add_product_binding.dart';
import 'package:purchase_request_manager/features/admin/products/edit/edit_product_binding.dart';
import 'package:purchase_request_manager/features/admin/products/page/products_binding.dart';
import 'package:purchase_request_manager/features/admin/products/add/add_product_page.dart';
import 'package:purchase_request_manager/features/admin/products/edit/edit_product_page.dart';
import 'package:purchase_request_manager/features/admin/products/page/products_page.dart';
import 'package:purchase_request_manager/features/auth/login/login_binding.dart';
import 'package:purchase_request_manager/features/auth/register/register_binding.dart';
import 'package:purchase_request_manager/features/auth/splash/splash_binding.dart';
import 'package:purchase_request_manager/features/auth/login/login_page.dart';
import 'package:purchase_request_manager/features/auth/register/register_page.dart';
import 'package:purchase_request_manager/features/auth/splash/splash_page.dart';
import 'package:purchase_request_manager/features/user/home_binding.dart';
import 'package:purchase_request_manager/features/user/home_page.dart';

class AppRoute {
  static final List<GetPage> routes = [
    GetPage(
      name: "/",
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutesConst.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    // Auth routes
    GetPage(
      name: AppRoutesConst.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutesConst.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),

    // Admin routes
    GetPage(
      name: AppRoutesConst.adminDashboard,
      page: () => const AdminDashboardPage(),
      binding: AdminDashboardBinding(),
    ),

    // Categories
    GetPage(
      name: AppRoutesConst.adminCategories,
      page: () => const AdminCategoriesPage(),
      binding: AdminCategoriesBinding(),
    ),
    GetPage(
      name: AppRoutesConst.adminCategoryProducts,
      page: () => const AdminCategoryProductsPage(),
      binding: AdminCategoryProductsBinding(),
    ),
    GetPage(
      name: AppRoutesConst.adminAddCategory,
      page: () => const AdminAddCategoryPage(),
      binding: AdminAddCategoryBinding(),
    ),
    GetPage(
      name: AppRoutesConst.adminEditCategory,
      page: () => const AdminEditCategoryPage(),
      binding: AdminEditCategoryBinding(),
    ),

    // Orders
    GetPage(
      name: AppRoutesConst.adminOrders,
      page: () => const AdminOrdersPage(),
      binding: AdminOrdersBinding(),
    ),
    GetPage(
      name: AppRoutesConst.adminAddOrders,
      page: () => const AdminAddOrdersPage(),
      binding: AdminAddOrdersBinding(),
    ),
    GetPage(
      name: AppRoutesConst.adminEditOrders,
      page: () => const AdminEditOrdersPage(),
      binding: AdminEditOrdersBinding(),
    ),
    GetPage(
      name: AppRoutesConst.adminOrderDetails,
      page: () => const AdminOrderDetailsPage(),
      binding: AdminOrderDetailsBinding(),
    ),

    // Products
    GetPage(
      name: AppRoutesConst.adminProducts,
      page: () => const AdminProductsPage(),
      binding: AdminProductsBinding(),
    ),
    GetPage(
      name: AppRoutesConst.adminAddProduct,
      page: () => const AdminAddProductPage(),
      binding: AdminAddProductBinding(),
    ),
    GetPage(
      name: AppRoutesConst.adminEditProduct,
      page: () => const AdminEditProductPage(),
      binding: AdminEditProductBinding(),
    ),
  ];
}
