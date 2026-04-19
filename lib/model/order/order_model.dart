// المودل الرئيسي للطلب وحالته
import 'package:purchase_request_manager/model/order/order_detail_model.dart';
import 'package:purchase_request_manager/model/user_model.dart';

class OrderModel {
  int? id;
  int? userId;
  String? status;
  double? totalEstimatedPrice;
  String? notes;
  String? createdAt;
  UserModel? user; // الموظف صاحب الطلب
  List<OrderDetailModel>? details; // قائمة المنتجات داخل الطلب

  OrderModel({
    this.id,
    this.userId,
    this.status,
    this.totalEstimatedPrice,
    this.notes,
    this.createdAt,
    this.user,
    this.details,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      status: json['status'],
      totalEstimatedPrice: json['total_estimated_price'] != null
          ? double.tryParse(json['total_estimated_price'].toString())
          : 0.0,
      notes: json['notes'],
      createdAt: json['created_at'],
      // جلب بيانات الموظف إذا كانت موجودة
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      // تحويل قائمة التفاصيل من JSON إلى List of Models
      details: json['details'] != null
          ? (json['details'] as List)
                .map((i) => OrderDetailModel.fromJson(i))
                .toList()
          : [],
    );
  }
}
