import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/constant/app_route.dart';
import 'package:purchase_request_manager/features/user/orders/controller/orders_controller.dart';
import 'package:purchase_request_manager/core/class/handling_data_view.dart';
import 'package:purchase_request_manager/model/order_model.dart';

class OrdersPage extends GetView<OrdersController> {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلبات الشراء'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: controller.refreshData,
            icon: const Icon(Icons.refresh),
          ),
          if (controller.authController.canManageInventory)
            IconButton(
              onPressed: () => Get.toNamed(AppRoutesConst.adminDashboard),
              icon: const Icon(Icons.inventory_2),
            ),
          IconButton(
            onPressed: () async {
              await controller.authController.logout();
              Get.offAllNamed(AppRoutesConst.login);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutesConst.addOrder),
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<OrdersController>(
        builder: (controller) => HandlingDataView(
          state: controller.stateRequest,
          child: RefreshIndicator(
            onRefresh: controller.refreshData,
            child: controller.orders.isEmpty
                ? const Center(
                    child: Text(
                      'لا توجد طلبات',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.orders.length,
                    itemBuilder: (context, index) {
                      final OrderModel order = controller.orders[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          title: Text(
                            'Order #${order.id}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Status: ${order.status}\n${(order.notes ?? '').isEmpty ? 'No notes' : order.notes}',
                          ),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) =>
                                controller.updateStatus(order.id, value),
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: 'pending',
                                child: Text('pending'),
                              ),
                              PopupMenuItem(
                                value: 'purchased',
                                child: Text('purchased'),
                              ),
                              PopupMenuItem(
                                value: 'delivered',
                                child: Text('delivered'),
                              ),
                            ],
                            icon: const Icon(Icons.more_vert),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
