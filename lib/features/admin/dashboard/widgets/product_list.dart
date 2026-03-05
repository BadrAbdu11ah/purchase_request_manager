import 'package:flutter/material.dart';
import 'package:purchase_request_manager/model/product_model.dart';

class AdminProductList extends StatelessWidget {
  final List<ProductModel> products;
  final void Function(ProductModel product) onEdit;
  final void Function(int id) onDelete;

  const AdminProductList({
    super.key,
    required this.products,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('لا توجد منتجات'));
    }

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (_, index) {
        final product = products[index];

        return Card(
          child: ListTile(
            title: Text(product.name),
            subtitle: Text(
              'الصنف: ${product.category?.name ?? '-'} | الوحدة: ${product.unit ?? '-'} | الحد الأدنى: ${product.minLimit ?? '-'}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => onEdit(product),
                  icon: const Icon(Icons.edit, color: Colors.blue),
                ),
                IconButton(
                  onPressed: () => onDelete(product.id),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}