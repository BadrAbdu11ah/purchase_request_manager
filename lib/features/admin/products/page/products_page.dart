import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/core/class/handling_data_view.dart';
import 'package:purchase_request_manager/features/admin/products/page/products_controller.dart';
import 'package:purchase_request_manager/features/admin/products/widgets/custom_card_product.dart';

class AdminProductsPage extends GetView<AdminProductsControllerImp> {
  const AdminProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة المنتجات')),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToAddProductPage,

        child: const Icon(Icons.add),
      ),
      body: GetBuilder<AdminProductsControllerImp>(
        builder: (controller) => HandlingDataView(
          state: controller.stateRequest,
          child: RefreshIndicator(
            onRefresh: controller.refreshData,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                final product = controller.products[index];
                return CustomCardProduct(
                  product: product,
                  onEdit: () => controller.goToEditProductPage(product),
                  onDelete: () => controller.deleteProduct(product.id),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
