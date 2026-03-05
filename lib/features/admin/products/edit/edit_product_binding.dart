import 'package:get/get.dart';
import 'package:purchase_request_manager/features/admin/products/edit/edit_product_controller.dart';

class AdminEditProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminEditProductControllerImp>(
      () => AdminEditProductControllerImp(),
    );
  }
}
