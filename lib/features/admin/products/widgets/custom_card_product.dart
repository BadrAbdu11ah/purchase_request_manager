import 'package:flutter/material.dart';
import 'package:purchase_request_manager/model/product_model.dart';

class CustomCardProduct extends StatelessWidget {
  final ProductModel product;
  final void Function() onEdit;
  final void Function() onDelete;
  const CustomCardProduct({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final categoryName = product.category?.name ?? 'غير محدد';
    final unit = (product.unit == null || product.unit!.trim().isEmpty)
        ? 'غير محدد'
        : product.unit!;
    final minLimit = (product.minLimit == null || product.minLimit!.trim().isEmpty)
        ? 'غير محدد'
        : product.minLimit!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(product.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('ID: ${product.id}'),
              Text('الصنف: $categoryName'),
              Text('الوحدة: $unit'),
              Text('الحد الأدنى: $minLimit'),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => onEdit(),
                icon: const Icon(Icons.edit, color: Colors.blue),
              ),
              IconButton(
                onPressed: () => onDelete(),
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
