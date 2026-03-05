import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/features/admin/categories/data/categories_data.dart';
import 'package:purchase_request_manager/features/admin/dashboard/dashboard_controller.dart';
import 'package:purchase_request_manager/features/admin/products/data/products_data.dart';
import 'package:purchase_request_manager/features/admin/products/page/products_controller.dart';
import 'package:purchase_request_manager/model/category_model.dart';
import 'package:purchase_request_manager/services/api_service.dart';

abstract class AdminAddProductController extends GetxController {
  final ProductsData productsData = ProductsData(Get.find<ApiService>());
  final CategoriesData categoriesData = CategoriesData(Get.find<ApiService>());

  late TextEditingController nameController;
  late TextEditingController unitController;
  late TextEditingController minLimitController;
  StateRequest stateRequest = StateRequest.none;

  List<CategoryModel> categories = [];
  String? selectedCategoryName;
  String? selectedCategoryId;

  Future<void> addProduct();
  Future<void> loadCategories();
  void chooseCategory(String id, String name);
  void clearSelectedCategory();
}

class AdminAddProductControllerImp extends AdminAddProductController {
  @override
  void onInit() {
    super.onInit();
    loadCategories();
    nameController = TextEditingController();
    unitController = TextEditingController();
    minLimitController = TextEditingController();
  }

  @override
  Future<void> addProduct() async {
    stateRequest = StateRequest.loading;
    update();

    final result = await productsData.addProduct(
      nameController.text,
      selectedCategoryId == null ? null : int.tryParse(selectedCategoryId!),
      unitController.text,
      minLimitController.text,
    );

    return result.fold(
      (_) {
        Get.snackbar('خطأ', 'فشل إضافة المنتج');
        stateRequest = StateRequest.none;
        update();
      },
      (response) async {
        Get.back();
        Get.snackbar('نجاح', 'تمت إضافة المنتج بنجاح');
        AdminProductsControllerImp controller = Get.find();
        controller.products.add(response);
        controller.update();

        AdminDashboardControllerImp dashboardController = Get.find();
        dashboardController.products++;
        dashboardController.update();
      },
    );
  }

  @override
  Future<void> loadCategories() async {
    stateRequest = StateRequest.loading;
    update();
    final result = await categoriesData.getCategories();
    result.fold((failure) => stateRequest = failure, (data) {
      stateRequest = StateRequest.success;
      categories = data;
    });
    update();
  }

  @override
  void chooseCategory(String id, String name) {
    selectedCategoryId = id;
    selectedCategoryName = name;
    Get.back();
    update();
  }

  @override
  void clearSelectedCategory() {
    selectedCategoryId = null;
    selectedCategoryName = null;
    Get.back();
    update();
  }
}
