import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/core/class/handling_data_view.dart';
import 'package:purchase_request_manager/features/admin/orders/page/orders_controller.dart';
import 'package:purchase_request_manager/features/admin/orders/widgets/card_orders.dart';
import 'package:purchase_request_manager/model/order/order_model.dart';

class AdminOrdersPage extends GetView<AdminOrdersController> {
  const AdminOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة الطلبات')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.goToAddOrder();
        },
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<AdminOrdersController>(
        builder: (controller) => HandlingDataView(
          state: controller.stateRequest,
          child: _buildOrdersList(controller.orders),
        ),
      ),
    );
  }

  Widget _buildOrdersList(List<OrderModel> orders) {
    if (controller.orders.isEmpty) {
      return const Center(child: Text('لا توجد طلبات'));
    } else {
      return RefreshIndicator(
        onRefresh: controller.refreshData,
        child: ListView.builder(
          controller: controller.scrollController, // ربط المتحكم هنا
          itemCount:
              controller.orders.length +
              (controller.isPaginationLoading ? 1 : 0),
          itemBuilder: (context, index) {
            // إذا كان الـ إندكس ضمن قائمة الطلبات، اعرض الكارت
            if (index < controller.orders.length) {
              return OrderCard(
                orderModel: controller.orders[index],
                onDelete: () {
                  Get.defaultDialog(
                    title: 'تأكيد الحذف',
                    middleText: 'هل أنت متأكد أنك تريد حذف هذا الطلب؟',
                    textCancel: 'إلغاء',
                    textConfirm: 'حذف',
                    onConfirm: () {
                      controller.deleteOrder(controller.orders[index].id!);
                      Get.back();
                    },
                  );
                },
                onCardTap: () {
                  controller.goToOrderDetails(controller.orders[index].id!);
                },
              );
            } else {
              // إذا وصلنا للـ إندكس الأخير وجاري التحميل، اظهر اللودينق الصغير
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      );
    }
  }
}
