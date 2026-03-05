class CategoryModel {
  final int id;
  final String name;
  final int? productsCount;

  const CategoryModel({
    required this.id,
    required this.name,
    this.productsCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: (json['name'] ?? '') as String,
      productsCount: json['products_count'] as int?,
    );
  }
}