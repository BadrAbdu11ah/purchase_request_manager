import 'product_model.dart';

class OrderDetailModel {
  final int id;
  final int productId;
  final double quantity;
  final ProductModel? product;

  const OrderDetailModel({
    required this.id,
    required this.productId,
    required this.quantity,
    this.product,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      id: (json['id'] ?? 0) as int,
      productId: (json['product_id'] ?? 0) as int,
      quantity: double.tryParse('${json['quantity'] ?? 0}') ?? 0,
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'] as Map<String, dynamic>)
          : null,
    );
  }
}
