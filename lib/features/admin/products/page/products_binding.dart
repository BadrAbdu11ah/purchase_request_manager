import 'package:get/get.dart';
import 'package:purchase_request_manager/features/admin/products/page/products_controller.dart';

class AdminProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminProductsControllerImp>(() => AdminProductsControllerImp());
  }
}
