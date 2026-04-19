import 'package:get/get.dart';
import 'package:purchase_request_manager/features/admin/orders/details/order_details_controller.dart';

class AdminOrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminOrderDetailsControllerImp>(
      () => AdminOrderDetailsControllerImp(),
    );
  }
}
