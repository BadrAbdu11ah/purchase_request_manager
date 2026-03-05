import 'package:get/get.dart';
import 'package:purchase_request_manager/features/admin/categories/edit/edit_category_controller.dart';

class AdminEditCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminEditCategoryController>(
      () => AdminEditCategoryControllerImp(),
    );
  }
}
