import 'package:get/get.dart';
import 'package:purchase_request_manager/features/user/orders/controller/orders_controller.dart';
import 'package:purchase_request_manager/services/order_service.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersController>(
      () => OrdersController(orderService: Get.find<OrderService>()),
    );
  }
}
