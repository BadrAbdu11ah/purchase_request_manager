import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/constant/app_route.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/features/admin/orders/data/orders_data.dart';
import 'package:purchase_request_manager/model/order/order_model.dart';
import 'package:purchase_request_manager/services/api_service.dart';

abstract class AdminOrdersController extends GetxController {
  final OrdersData ordersData = OrdersData(Get.find<ApiService>());
  late ScrollController scrollController;
  StateRequest stateRequest = StateRequest.none;

  List<OrderModel> orders = [];
  int currentPage = 1;
  bool isLastPage = false;
  bool isPaginationLoading = false;

  Future<void> refreshData();
  Future<void> loadOrders();
  Future<void> deleteOrder(int orderId);
  void goToAddOrder();
  void goToOrderDetails(int orderId);
  void goToEditOrder(int orderId);
}

class AdminOrdersControllerImp extends AdminOrdersController {
  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    // إضافة مستمع لحركة التمرير
    scrollController.addListener(() {
      // إذا وصل المستخدم قبل نهاية الصفحة بـ 200 بكسل، ابدأ تحميل الجديد
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        loadOrders();
      }
    });
    loadOrders();
  }

  @override
  Future<void> refreshData() async {
    await loadOrders();
  }

  @override
  Future<void> loadOrders() async {
    if (isLastPage || isPaginationLoading) return;

    // 1. إذا كانت الصفحة الأولى، نظهر اللودينق الكامل
    if (currentPage == 1) {
      stateRequest = StateRequest.loading;
      update();
    } else {
      // 2. إذا كانت صفحات إضافية، نرفع علامة التحميل الجزئي فقط
      isPaginationLoading = true;
      update();
    }

    var response = await ordersData.getOrders(currentPage);

    response.fold(
      (failure) {
        stateRequest = failure;
        isPaginationLoading = false;
      },
      (paginatedData) {
        stateRequest = StateRequest.success;
        isPaginationLoading = false;

        orders.addAll(paginatedData.orders);

        // التحقق من الوصول لنهاية البيانات
        if (paginatedData.currentPage >= paginatedData.lastPage) {
          isLastPage = true;
        } else {
          currentPage++;
        }
      },
    );

    update();
  }

  @override
  void goToAddOrder() {
    Get.toNamed(AppRoutesConst.adminAddOrders);
  }

  @override
  Future<void> deleteOrder(orderId) {
    orders.removeWhere((order) => order.id == orderId);
    update();
    return ordersData.removeOrder(orderId).then((result) {
      result.fold(
        (_) {
          Get.snackbar(
            'Error',
            'Failed to delete order',
            snackPosition: SnackPosition.BOTTOM,
          );
          stateRequest = StateRequest.failure;
          update();
        },
        (_) {
          Get.snackbar(
            'Success',
            'Order deleted successfully',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      );
    });
  }

  @override
  void goToOrderDetails(orderId) {
    Get.toNamed(AppRoutesConst.adminOrderDetails, arguments: orderId);
  }

  @override
  void goToEditOrder(int orderId) {
    Get.toNamed(AppRoutesConst.adminEditOrders, arguments: orderId);
  }
}
