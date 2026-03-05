import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/core/class/handling_data_view.dart';
import 'package:purchase_request_manager/features/admin/products/add/add_product_controller.dart';
import 'package:purchase_request_manager/features/admin/products/widgets/show_categories_bottom_sheet.dart';

class AdminAddProductPage extends GetView<AdminAddProductControllerImp> {
  const AdminAddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إضافة منتج')),
      body: GetBuilder<AdminAddProductControllerImp>(
        builder: (controller) => HandlingDataView(
          state: controller.stateRequest,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    labelText: 'اسم المنتج',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      ShowCategoriesBottomSheet(
                        categories: controller.categories,
                        onTap: (category) {
                          controller.chooseCategory(
                            category.id.toString(),
                            category.name,
                          );
                        },
                        onDelete: () {
                          controller.clearSelectedCategory();
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.selectedCategoryName ?? "اختر الصنف"),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: controller.unitController,
                  decoration: InputDecoration(
                    labelText: 'الوحدة',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: controller.minLimitController,
                  decoration: InputDecoration(
                    labelText: 'الحد الأدنى',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => controller.addProduct(),
                  child: Text('إضافة'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
