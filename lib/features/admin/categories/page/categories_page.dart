import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/core/class/handling_data_view.dart';
import 'package:purchase_request_manager/features/admin/categories/page/categories_controller.dart';
import 'package:purchase_request_manager/features/admin/categories/widgets/custom_card_category.dart';

class AdminCategoriesPage extends GetView<AdminCategoriesControllerImp> {
  const AdminCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة الأصناف')),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToAddCategoryPage,

        child: const Icon(Icons.add),
      ),
      body: GetBuilder<AdminCategoriesControllerImp>(
        builder: (_) => HandlingDataView(
          state: controller.stateRequest,
          child: controller.categories.isEmpty
              ? const Center(
                  child: Text('لا توجد أصناف', style: TextStyle(fontSize: 20)),
                )
              : RefreshIndicator(
                  onRefresh: controller.refreshData,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      return CustomCardCategory(
                        name: category.name,
                        productsCount: category.productsCount!,
                        onEdit: () => controller.goToEditCategoryPage(category),
                        onDelete: () => controller.deleteCategory(category.id),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
