import 'package:get/get.dart';
import 'package:purchase_request_manager/features/admin/orders/edit/edit_orders_controller.dart';

class AdminEditOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminEditOrdersControllerImp>(
      () => AdminEditOrdersControllerImp(),
    );
  }
}
