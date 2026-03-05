import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/features/admin/categories/data/categories_data.dart';
import 'package:purchase_request_manager/features/admin/categories/page/categories_controller.dart';
import 'package:purchase_request_manager/model/category_model.dart';
import 'package:purchase_request_manager/services/api_service.dart';

abstract class AdminEditCategoryController extends GetxController {
  late TextEditingController nameController;
  late CategoryModel category;
  Future<void> editCategory(int id);
}

class AdminEditCategoryControllerImp extends AdminEditCategoryController {
  final CategoriesData categoriesData = CategoriesData(Get.find<ApiService>());

  StateRequest stateRequest = StateRequest.none;

  @override
  void onInit() {
    super.onInit();
    category = Get.arguments as CategoryModel;
    nameController = TextEditingController(text: category.name);
  }

  @override
  Future<void> editCategory(int id) async {
    stateRequest = StateRequest.loading;
    update();

    final result = await categoriesData.editCategories(id, nameController.text);

    return result.fold((_) => Get.snackbar('خطأ', 'فشل تعديل الصنف'), (
      response,
    ) async {
      Get.snackbar('نجاح', 'تم تعديل الصنف بنجاح');
      Get.back();

      AdminCategoriesControllerImp controller = Get.find();
      controller.categories.removeWhere((element) => element.id == response.id);
      controller.categories.add(response);
      controller.update();
    });
  }
}
