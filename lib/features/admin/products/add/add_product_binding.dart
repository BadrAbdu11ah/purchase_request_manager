import 'package:get/get.dart';
import 'package:purchase_request_manager/features/admin/products/add/add_product_controller.dart';

class AdminAddProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAddProductControllerImp>(
      () => AdminAddProductControllerImp(),
    );
  }
}
