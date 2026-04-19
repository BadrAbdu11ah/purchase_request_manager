import 'package:get/get.dart';
import 'package:purchase_request_manager/constant/app_route.dart';
import 'package:purchase_request_manager/features/admin/dashboard/dashboard_data.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';

import 'package:purchase_request_manager/services/api_service.dart';

abstract class AdminDashboardController extends GetxController {
  final DashboardData dashboardData = DashboardData(Get.find<ApiService>());

  StateRequest stateRequest = StateRequest.none;

  Map<String, dynamic> dashboardStats = {};

  int totalOrders = 0;
  int totalProducts = 0;
  int totalCategories = 0;

  Future<void> refreshData();
  Future<void> getDashboardData();

  void goToCategoriesPage();
  void goToProductsPage();
  void goToOrdersPage();
}

class AdminDashboardControllerImp extends AdminDashboardController {
  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  @override
  Future<void> refreshData() async {
    await getDashboardData();
  }

  @override
  Future<void> getDashboardData() async {
    stateRequest = StateRequest.loading;
    update();

    var response = await dashboardData.getDashboardData();

    response.fold((failure) => stateRequest = failure, (data) {
      stateRequest = StateRequest.success;
      dashboardStats = data['data'];
      totalOrders = dashboardStats['total_orders'] ?? 0;
      totalProducts = dashboardStats['total_products'] ?? 0;
      totalCategories = dashboardStats['total_categories'] ?? 0;
    });
    update();
  }

  @override
  void goToCategoriesPage() {
    Get.toNamed(AppRoutesConst.adminCategories);
  }

  @override
  void goToOrdersPage() {
    Get.toNamed(AppRoutesConst.adminOrders);
  }

  @override
  void goToProductsPage() {
    Get.toNamed(AppRoutesConst.adminProducts);
  }
}
