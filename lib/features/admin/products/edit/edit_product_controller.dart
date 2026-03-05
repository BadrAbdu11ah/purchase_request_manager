import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/features/admin/categories/data/categories_data.dart';
import 'package:purchase_request_manager/features/admin/dashboard/dashboard_controller.dart';
import 'package:purchase_request_manager/features/admin/products/data/products_data.dart';
import 'package:purchase_request_manager/features/admin/products/page/products_controller.dart';
import 'package:purchase_request_manager/model/category_model.dart';
import 'package:purchase_request_manager/model/product_model.dart';
import 'package:purchase_request_manager/services/api_service.dart';

abstract class AdminEditProductController extends GetxController {
  final ProductsData productsData = ProductsData(Get.find<ApiService>());
  final CategoriesData categoriesData = CategoriesData(Get.find<ApiService>());

  late ProductModel product;
  late TextEditingController nameController;
  late TextEditingController unitController;
  late TextEditingController minLimitController;
  StateRequest stateRequest = StateRequest.none;

  List<CategoryModel> categories = [];
  String? selectedCategoryName;
  String? selectedCategoryId;

  Future<void> updateProduct();
  Future<void> loadCategories();
  void chooseCategory(String id, String name);
  void clearSelectedCategory();
}

class AdminEditProductControllerImp extends AdminEditProductController {
  @override
  void onInit() {
    super.onInit();
    product = Get.arguments as ProductModel;
    loadCategories();
    nameController = TextEditingController(text: product.name);
    unitController = TextEditingController(text: product.unit);
    minLimitController = TextEditingController(
      text: product.minLimit.toString(),
    );
  }

  @override
  Future<void> updateProduct() async {
    stateRequest = StateRequest.loading;
    update();

    final result = await productsData.editProducts(
      product.id,
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
        Get.snackbar('نجاح', 'تمت تعديل المنتج بنجاح');
        AdminProductsControllerImp controller = Get.find();
        controller.products.removeWhere((element) => element.id == response.id);
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
