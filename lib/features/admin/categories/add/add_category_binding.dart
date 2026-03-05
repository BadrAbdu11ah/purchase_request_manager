import 'package:get/get.dart';
import 'package:purchase_request_manager/features/admin/categories/add/add_category_controller.dart';

class AdminAddCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAddCategoryControllerImp>(
      () => AdminAddCategoryControllerImp(),
    );
  }
}
