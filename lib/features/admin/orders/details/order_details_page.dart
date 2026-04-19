import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/core/class/handling_data_view.dart';
import 'package:purchase_request_manager/features/admin/orders/details/order_details_controller.dart';
import 'package:purchase_request_manager/model/order/order_detail_model.dart';
import 'package:purchase_request_manager/model/order/order_model.dart';

class AdminOrderDetailsPage extends GetView<AdminOrderDetailsController> {
  const AdminOrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تفاصيل الطلب')),
      body: GetBuilder<AdminOrderDetailsController>(
        builder: (controller) => HandlingDataView(
          state: controller.stateRequest,
          child: _buildOrderDetails(controller),
        ),
      ),
    );
  }

  Widget _buildOrderDetails(AdminOrderDetailsController controller) {
    final order = controller.orderDetails;

    if (order == null) {
      return const Center(child: Text('لم يتم تحميل تفاصيل الطلب...'));
    }

    final detailsList = order.details ?? [];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderHeaderCard(order),
            const Divider(height: 30),
            const Text(
              "الأصناف المطلوبة:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            _buildOrderDetailsList(detailsList),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHeaderCard(OrderModel order) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "رقم الطلب: #${order.id ?? 'غير متوفر'}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildOrderInfoRow("المسؤول:", order.user?.name ?? 'غير معروف'),
            const SizedBox(height: 8),
            _buildOrderInfoRow(
              "التاريخ:",
              order.createdAt != null && order.createdAt!.length >= 10
                  ? order.createdAt!.substring(0, 10)
                  : 'غير متوفر',
            ),
            const SizedBox(height: 8),
            _buildOrderInfoRow("الحالة:", order.status ?? 'قيد المعالجة'),
            const SizedBox(height: 8),
            _buildOrderInfoRow(
              "السعر الإجمالي المقدر:",
              "${order.totalEstimatedPrice ?? 0} SAR",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetailsList(List<OrderDetailModel> detailsList) {
    if (detailsList.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("لا توجد أصناف في هذا الطلب"),
        ),
      );
    }

    return Column(
      children: List.generate(detailsList.length, (index) {
        final detail = detailsList[index];
        return _buildDetailItem(detail, index);
      }),
    );
  }

  Widget _buildDetailItem(OrderDetailModel detail, int index) {
    final productName = detail.product?.name ?? 'منتج غير معروف';
    final quantity = detail.quantity?.toInt() ?? 0;
    final price = detail.product?.price ?? 0;
    final productId = detail.productId ?? 'N/A';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "${index + 1}. $productName",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "رقم المنتج: $productId",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("الكمية: $quantity وحدة"),
                Text("السعر: $price SAR"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
