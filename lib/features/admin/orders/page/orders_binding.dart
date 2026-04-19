import 'package:get/get.dart';
import 'package:purchase_request_manager/features/admin/orders/page/orders_controller.dart';

class AdminOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminOrdersController>(() => AdminOrdersControllerImp());
  }
}
