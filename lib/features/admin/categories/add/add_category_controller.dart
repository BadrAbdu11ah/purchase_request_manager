import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/features/admin/categories/data/categories_data.dart';
import 'package:purchase_request_manager/features/admin/categories/page/categories_controller.dart';
import 'package:purchase_request_manager/features/admin/dashboard/dashboard_controller.dart';
import 'package:purchase_request_manager/services/api_service.dart';

abstract class AdminAddCategoryController extends GetxController {
  final CategoriesData categoriesData = CategoriesData(Get.find<ApiService>());
  late TextEditingController nameController;
  StateRequest stateRequest = StateRequest.none;

  Future<void> addCategory();
}

class AdminAddCategoryControllerImp extends AdminAddCategoryController {
  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
  }

  @override
  Future<void> addCategory() async {
    stateRequest = StateRequest.loading;
    update();

    final result = await categoriesData.addCategories(nameController.text);

    return result.fold((_) => Get.snackbar('خطأ', 'فشل إضافة الصنف'), (
      response,
    ) async {
      Get.back();
      Get.snackbar('نجاح', 'تمت إضافة الصنف بنجاح');
      AdminCategoriesControllerImp controller = Get.find();
      controller.categories.add(response);
      controller.update();

      AdminDashboardControllerImp dashboardController = Get.find();
      dashboardController.categories++;
      dashboardController.update();
    });
  }
}
