import 'package:get/get.dart';
import 'package:purchase_request_manager/features/admin/orders/add/add_orders_controller.dart';

class AdminAddOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAddOrdersControllerImp>(
      () => AdminAddOrdersControllerImp(),
    );
  }
}
