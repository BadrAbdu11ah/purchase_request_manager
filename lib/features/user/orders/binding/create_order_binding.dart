import 'package:get/get.dart';
import 'package:purchase_request_manager/features/user/orders/controller/create_order_controller.dart';

class CreateOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateOrderController>(() => CreateOrderController());
  }
}
