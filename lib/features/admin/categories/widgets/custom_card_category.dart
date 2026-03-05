import 'package:flutter/material.dart';

class CustomCardCategory extends StatelessWidget {
  final String name;
  final int productsCount;
  final void Function() onEdit;
  final void Function() onDelete;
  const CustomCardCategory({
    super.key,
    required this.name,
    required this.productsCount,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(name),
          subtitle: Text('عدد المنتجات: $productsCount'),
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
