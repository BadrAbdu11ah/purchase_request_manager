import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/model/category_model.dart';

class ShowCategoriesBottomSheet extends StatelessWidget {
  final List<CategoryModel> categories;
  final void Function(CategoryModel) onTap;
  final void Function() onDelete;

  const ShowCategoriesBottomSheet({
    super.key,
    required this.categories,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text("لا توجد أصناف", style: TextStyle(fontSize: 20)),
        ),
      );
    }
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "التصنيفات المتاحة",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => onTap(categories[index]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12,
                        ),
                        child: Text(
                          categories[index].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          InkWell(
            onTap: () => onDelete(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.5 - 40,
                    vertical: 12,
                  ),
                  child: Text("فارغ", style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
