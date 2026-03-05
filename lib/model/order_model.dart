import 'order_detail_model.dart';

class OrderModel {
  final int id;
  final String status;
  final String? notes;
  final List<OrderDetailModel> details;

  const OrderModel({
    required this.id,
    required this.status,
    this.notes,
    required this.details,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final rawDetails = (json['details'] ?? []) as List<dynamic>;
    return OrderModel(
      id: json['id'] as int,
      status: (json['status'] ?? '') as String,
      notes: json['notes'] as String?,
      details: rawDetails
          .map((item) => OrderDetailModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
