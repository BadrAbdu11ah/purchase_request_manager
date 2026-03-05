import 'package:flutter/material.dart';
import 'package:purchase_request_manager/model/category_model.dart';

class AdminCategoryList extends StatelessWidget {
  final List<CategoryModel> categories;
  final void Function(CategoryModel category) onEdit;
  final void Function(int id) onDelete;

  const AdminCategoryList({
    super.key,
    required this.categories,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const Center(child: Text('لا توجد أصناف'));
    }

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (_, index) {
        final category = categories[index];

        return Card(
          child: ListTile(
            title: Text(category.name),
            subtitle: Text('عدد المنتجات: ${category.productsCount ?? 0}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => onEdit(category),
                  icon: const Icon(Icons.edit, color: Colors.blue),
                ),
                IconButton(
                  onPressed: () => onDelete(category.id),
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