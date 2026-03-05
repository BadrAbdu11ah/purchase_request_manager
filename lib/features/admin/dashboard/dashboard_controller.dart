import 'package:get/get.dart';
import 'package:purchase_request_manager/constant/app_route.dart';
import 'package:purchase_request_manager/features/admin/dashboard/dashboard_data.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';

import 'package:purchase_request_manager/services/api_service.dart';

abstract class AdminDashboardController extends GetxController {
  Future<void> refreshData();
  Future<void> loadCategories();
  Future<void> loadProducts();
  Future<void> loadOrders();
  Future<void> addCategory(String name);
  Future<void> updateCategory(int id, String name);
  Future<void> deleteCategory(int id);
  Future<void> addProduct({
    required String name,
    required int categoryId,
    required String unit,
    required String minLimit,
  });
  Future<void> updateProduct({
    required int id,
    required String name,
    required int categoryId,
    required String unit,
    required String minLimit,
  });
  Future<void> deleteProduct(int id);
  void goToCategoriesPage();
  void goToProductsPage();
  void goToOrdersPage();
}

class AdminDashboardControllerImp extends AdminDashboardController {
  final DashboardData dashboardData = DashboardData(Get.find<ApiService>());

  StateRequest stateRequest = StateRequest.none;

  int categories = 0;
  int products = 0;
  int orders = 0;

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  @override
  Future<void> refreshData() async {
    stateRequest = StateRequest.loading;
    update();
    await loadCategories();
    if (stateRequest != StateRequest.success) {
      update();
      return;
    }
    await loadProducts();
    if (stateRequest != StateRequest.success) {
      update();
      return;
    }
    await loadOrders();
    if (stateRequest != StateRequest.success) {
      update();
      return;
    }
    update();
  }

  @override
  Future<void> loadCategories() async {
    final result = await dashboardData.getCategories();
    print("Categories result: $result");
    result.fold((failure) => stateRequest = failure, (data) {
      stateRequest = StateRequest.success;
      categories = data.length;
    });
  }

  @override
  Future<void> loadProducts() async {
    final result = await dashboardData.getProducts();
    result.fold((failure) => stateRequest = failure, (data) {
      stateRequest = StateRequest.success;
      products = data.length;
    });
  }

  @override
  Future<void> loadOrders() async {
    final result = await dashboardData.getOrders();
    result.fold((failure) => stateRequest = failure, (data) {
      stateRequest = StateRequest.success;
      orders = data.length;
    });
  }

  @override
  Future<void> addCategory(String name) async {
    // final result = await apiService.post(ApiEndpoints.categoryStore, {
    //   'name': name.trim(),
    // });

    // result.fold((_) => Get.snackbar('Ø®Ø·Ø£', 'ÙØ´Ù„ Ø¥Ø¶Ø§ÙØ© Ø§Ù„ØµÙ†Ù'), (
    //   _,
    // ) async {
    //   Get.snackbar('Ù†Ø¬Ø§Ø­', 'ØªÙ…Øª Ø¥Ø¶Ø§ÙØ© Ø§Ù„ØµÙ†Ù');
    //   await refreshData();
    // });
  }

  @override
  Future<void> updateCategory(int id, String name) async {
    // final result = await apiService.post(ApiEndpoints.categoryUpdate(id), {
    //   'name': name.trim(),
    // });

    // result.fold((_) => Get.snackbar('Ø®Ø·Ø£', 'ÙØ´Ù„ ØªØ¹Ø¯ÙŠÙ„ Ø§Ù„ØµÙ†Ù'), (
    //   _,
    // ) async {
    //   Get.snackbar('Ù†Ø¬Ø§Ø­', 'ØªÙ… ØªØ¹Ø¯ÙŠÙ„ Ø§Ù„ØµÙ†Ù');
    //   await refreshData();
    // });
  }

  @override
  Future<void> deleteCategory(int id) async {
    // final result = await apiService.delete(ApiEndpoints.categoryDelete(id));

    // result.fold((_) => Get.snackbar('Ø®Ø·Ø£', 'ÙØ´Ù„ Ø­Ø°Ù Ø§Ù„ØµÙ†Ù'), (
    //   _,
    // ) async {
    //   Get.snackbar('Ù†Ø¬Ø§Ø­', 'ØªÙ… Ø­Ø°Ù Ø§Ù„ØµÙ†Ù');
    //   await refreshData();
    // });
  }

  @override
  Future<void> addProduct({
    required String name,
    required int categoryId,
    required String unit,
    required String minLimit,
  }) async {
    // final limit = num.tryParse(minLimit);
    // if (limit == null) {
    //   Get.snackbar(
    //     'ØªÙ†Ø¨ÙŠÙ‡',
    //     'Ø§Ù„Ø­Ø¯ Ø§Ù„Ø£Ø¯Ù†Ù‰ ÙŠØ¬Ø¨ Ø£Ù† ÙŠÙƒÙˆÙ† Ø±Ù‚Ù…Ù‹Ø§',
    //   );
    //   return;
    // }

    // final result = await apiService.post(ApiEndpoints.productStore, {
    //   'name': name.trim(),
    //   'category_id': categoryId,
    //   'unit': unit.trim(),
    //   'min_limit': limit,
    // });

    // result.fold(
    //   (_) => Get.snackbar('Ø®Ø·Ø£', 'ÙØ´Ù„ Ø¥Ø¶Ø§ÙØ© Ø§Ù„Ù…Ù†ØªØ¬'),
    //   (_) async {
    //     Get.snackbar('Ù†Ø¬Ø§Ø­', 'ØªÙ…Øª Ø¥Ø¶Ø§ÙØ© Ø§Ù„Ù…Ù†ØªØ¬');
    //     await refreshData();
    //   },
    // );
  }

  @override
  Future<void> updateProduct({
    required int id,
    required String name,
    required int categoryId,
    required String unit,
    required String minLimit,
  }) async {
    // final limit = num.tryParse(minLimit);
    // if (limit == null) {
    //   Get.snackbar(
    //     'ØªÙ†Ø¨ÙŠÙ‡',
    //     'Ø§Ù„Ø­Ø¯ Ø§Ù„Ø£Ø¯Ù†Ù‰ ÙŠØ¬Ø¨ Ø£Ù† ÙŠÙƒÙˆÙ† Ø±Ù‚Ù…Ù‹Ø§',
    //   );
    //   return;
    // }

    // final result = await apiService.post(ApiEndpoints.productUpdate(id), {
    //   'name': name.trim(),
    //   'category_id': categoryId,
    //   'unit': unit.trim(),
    //   'min_limit': limit,
    // });

    // result.fold(
    //   (_) => Get.snackbar('Ø®Ø·Ø£', 'ÙØ´Ù„ ØªØ¹Ø¯ÙŠÙ„ Ø§Ù„Ù…Ù†ØªØ¬'),
    //   (_) async {
    //     Get.snackbar('Ù†Ø¬Ø§Ø­', 'ØªÙ… ØªØ¹Ø¯ÙŠÙ„ Ø§Ù„Ù…Ù†ØªØ¬');
    //     await refreshData();
    //   },
    // );
  }

  @override
  Future<void> deleteProduct(int id) async {
    // final result = await apiService.delete(ApiEndpoints.productDelete(id));

    // result.fold((_) => Get.snackbar('Ø®Ø·Ø£', 'ÙØ´Ù„ Ø­Ø°Ù Ø§Ù„Ù…Ù†ØªØ¬'), (
    //   _,
    // ) async {
    //   Get.snackbar('Ù†Ø¬Ø§Ø­', 'ØªÙ… Ø­Ø°Ù Ø§Ù„Ù…Ù†ØªØ¬');
    //   await refreshData();
    // });
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
