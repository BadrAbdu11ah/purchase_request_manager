import 'package:get/get.dart';
import 'package:purchase_request_manager/features/admin/categories/category_products/category_products_controller.dart';

class AdminCategoryProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminCategoryProductsController>(
      () => AdminCategoryProductsController(),
    );
  }
}
