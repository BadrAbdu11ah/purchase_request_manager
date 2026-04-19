// مودل تفاصيل الطلب المنتج والكمية
import 'package:purchase_request_manager/model/product_model.dart';

class OrderDetailModel {
  int? id;
  int? orderId;
  int? productId;
  double? quantity;
  double? actualPrice;
  ProductModel? product; // علاقة المنتج

  OrderDetailModel({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.actualPrice,
    this.product,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      // التأكد من تحويل الأرقام إلى double لتجنب أخطاء النوع
      quantity: double.tryParse(json['quantity'].toString()),
      actualPrice: json['actual_price'] != null
          ? double.tryParse(json['actual_price'].toString())
          : null,
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
    );
  }
}
