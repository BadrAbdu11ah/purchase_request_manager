import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/core/class/handling_data_view.dart';
import 'package:purchase_request_manager/features/admin/categories/edit/edit_category_controller.dart';

class AdminEditCategoryPage extends GetView<AdminEditCategoryControllerImp> {
  const AdminEditCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تعديل الصنف')),
      body: GetBuilder<AdminEditCategoryControllerImp>(
        builder: (controller) => HandlingDataView(
          state: controller.stateRequest,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: controller.nameController,
                  decoration: InputDecoration(labelText: 'اسم الصنف'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () =>
                      controller.editCategory(controller.category.id),
                  child: Text('تعديل'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
