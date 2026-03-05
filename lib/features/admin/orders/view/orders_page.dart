import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/features/admin/orders/controller/orders_controller.dart';

class AdminOrdersPage extends GetView<AdminOrdersController> {
  const AdminOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة الطلبات')),
      body: const Center(child: Text('Orders Management Page')),
    );
  }
}
