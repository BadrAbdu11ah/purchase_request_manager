// كارت لعرض ملخص الطلب
import 'package:flutter/material.dart';
import 'package:purchase_request_manager/model/order/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel orderModel;
  final void Function() onDelete;
  final void Function() onCardTap;
  const OrderCard({
    super.key,
    required this.orderModel,
    required this.onDelete,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onDelete,
      onTap: onCardTap,
      child: Card(
        margin: const EdgeInsets.all(8),
        child: ListTile(
          title: Text("طلب رقم: #${orderModel.id}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("بواسطة: ${orderModel.user?.name ?? 'غير معروف'}"),
              Text("التاريخ: ${orderModel.createdAt?.substring(0, 10)}"),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${orderModel.totalEstimatedPrice} SAR",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              // تلوين الحالة بناءً على نوعها
              Text(
                orderModel.status!,
                style: TextStyle(
                  color: orderModel.status == 'pending'
                      ? Colors.orange
                      : Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
