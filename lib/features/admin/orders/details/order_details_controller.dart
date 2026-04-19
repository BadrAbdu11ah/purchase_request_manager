import 'package:get/get.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/features/admin/orders/data/orders_data.dart';
import 'package:purchase_request_manager/model/order/order_model.dart';

abstract class AdminOrderDetailsController extends GetxController {
  OrdersData ordersData = OrdersData(Get.find());

  StateRequest stateRequest = StateRequest.none;
  OrderModel? orderDetails;

  late int orderId;

  Future<void> loadOrderDetails(int orderId);
}

class AdminOrderDetailsControllerImp extends AdminOrderDetailsController {
  @override
  void onInit() {
    super.onInit();
    // 1. استلام المعاملات بشكل آمن مع التحقق من النوع
    if (Get.arguments != null) {
      orderId = Get.arguments as int;
      _initializeOrderData();
    } else {
      print("Error: orderId is null");
      stateRequest = StateRequest.failure;
      update();
    }
  }

  Future<void> _initializeOrderData() async {
    await loadOrderDetails(orderId);
  }

  @override
  Future<void> loadOrderDetails(int orderId) async {
    try {
      // 2. تحديث الحالة إلى "جاري التحميل"
      stateRequest = StateRequest.loading;
      update();

      // 3. طلب بيانات تفاصيل الطلب من السيرفر
      final result = await ordersData.getOrderDetails(orderId);

      result.fold(
        (failure) {
          // 4. في حالة حدوث خطأ في الاتصال أو البيانات
          print('Error loading order details: $failure');
          stateRequest = StateRequest.failure;
          update();
        },
        (order) {
          // 5. في حالة النجاح، تخزين البيانات وتحديث الحالة
          orderDetails = order;
          print(
            'Order loaded successfully: ID = ${order.id}, Details count = ${order.details?.length ?? 0}',
          );
          stateRequest = StateRequest.success;
          update();
        },
      );
    } catch (e) {
      print('Exception in loadOrderDetails: $e');
      stateRequest = StateRequest.failure;
      update();
    }
  }
}
