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
import 'package:purchase_request_manager/features/admin/orders/binding/order_details_binding.dart';
import 'package:purchase_request_manager/features/admin/orders/binding/orders_binding.dart';
import 'package:purchase_request_manager/features/admin/orders/view/order_details_page.dart';
import 'package:purchase_request_manager/features/admin/orders/view/orders_page.dart';
import 'package:purchase_request_manager/features/admin/products/add/add_product_binding.dart';
import 'package:purchase_request_manager/features/admin/products/edit/edit_product_binding.dart';
import 'package:purchase_request_manager/features/admin/products/page/products_binding.dart';
import 'package:purchase_request_manager/features/admin/products/add/add_product_page.dart';
import 'package:purchase_request_manager/features/admin/products/edit/edit_product_page.dart';
import 'package:purchase_request_manager/features/admin/products/page/products_page.dart';
import 'package:purchase_request_manager/features/user/auth/binding/login_binding.dart';
import 'package:purchase_request_manager/features/user/auth/binding/register_binding.dart';
import 'package:purchase_request_manager/features/user/auth/binding/splash_binding.dart';
import 'package:purchase_request_manager/features/user/auth/view/login_page.dart';
import 'package:purchase_request_manager/features/user/auth/view/register_page.dart';
import 'package:purchase_request_manager/features/user/auth/view/splash_page.dart';
import 'package:purchase_request_manager/features/user/orders/binding/create_order_binding.dart';
import 'package:purchase_request_manager/features/user/orders/binding/orders_binding.dart';
import 'package:purchase_request_manager/features/user/orders/view/create_order_page.dart';
import 'package:purchase_request_manager/features/user/orders/view/orders_page.dart';

class AppRoute {
  static final List<GetPage> routes = [
    GetPage(
      name: "/",
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutesConst.orders,
      page: () => const OrdersPage(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: AppRoutesConst.addOrder,
      page: () => const CreateOrder(),
      binding: CreateOrderBinding(),
    ),
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
