import 'package:get/get.dart';
import 'package:purchase_request_manager/features/admin/categories/page/categories_controller.dart';

class AdminCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminCategoriesControllerImp>(
      () => AdminCategoriesControllerImp(),
    );
  }
}
