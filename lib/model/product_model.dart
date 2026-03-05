import 'category_model.dart';

class ProductModel {
  final int id;
  final int? categoryId;
  final String name;
  final String? unit;
  final String? minLimit;
  final CategoryModel? category;

  const ProductModel({
    required this.id,
    this.categoryId,
    required this.name,
    this.unit,
    this.minLimit,
    this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      categoryId: json['category_id'] == null
          ? null
          : int.tryParse(json['category_id'].toString()),
      name: (json['name'] ?? '') as String,
      unit: json['unit']?.toString(),
      minLimit: json['min_limit']?.toString(),
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
          : null,
    );
  }
}
