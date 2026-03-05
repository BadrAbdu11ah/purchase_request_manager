import 'package:get/get.dart';
import 'package:purchase_request_manager/constant/app_route.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/features/admin/categories/data/categories_data.dart';
import 'package:purchase_request_manager/features/admin/dashboard/dashboard_controller.dart';
import 'package:purchase_request_manager/model/category_model.dart';
import 'package:purchase_request_manager/services/api_service.dart';

abstract class AdminCategoriesController extends GetxController {
  Future<void> refreshData();
  Future<void> loadCategories();
  void goToAddCategoryPage();
  void goToEditCategoryPage(CategoryModel category);
  Future<void> deleteCategory(int id);
}

class AdminCategoriesControllerImp extends AdminCategoriesController {
  final CategoriesData categoriesData = CategoriesData(Get.find<ApiService>());
  StateRequest stateRequest = StateRequest.none;

  List<CategoryModel> categories = [];

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
    update();
  }

  @override
  Future<void> loadCategories() async {
    final result = await categoriesData.getCategories();
    print("Categories result: $result");
    result.fold((failure) => stateRequest = failure, (data) {
      stateRequest = StateRequest.success;
      categories = data;
    });
  }

  @override
  Future<void> deleteCategory(int id) async {
    categories.removeWhere((category) => category.id == id);
    update();
    final result = await categoriesData.removeCategory(id);

    result.fold(
      (_) {
        Get.snackbar(
          'error',
          'error deleting category',
          snackPosition: SnackPosition.BOTTOM,
        );
        stateRequest = StateRequest.failure;
        update();
      },
      (_) async {
        AdminDashboardControllerImp dashboardController = Get.find();
        dashboardController.categories--;
        dashboardController.update();
        Get.snackbar(
          'نجاح',
          'تم حذف الصنف بنجاح',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  @override
  void goToAddCategoryPage() {
    Get.toNamed(AppRoutesConst.adminAddCategory);
  }

  @override
  void goToEditCategoryPage(CategoryModel category) {
    Get.toNamed(AppRoutesConst.adminEditCategory, arguments: category);
  }
}
