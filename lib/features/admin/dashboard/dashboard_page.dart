import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/features/admin/dashboard/dashboard_controller.dart';
import 'package:purchase_request_manager/core/class/handling_data_view.dart';
import 'package:purchase_request_manager/features/admin/dashboard/widgets/custom_card_count.dart';
import 'package:purchase_request_manager/features/admin/dashboard/widgets/custom_card_management.dart';

class AdminDashboardPage extends GetView<AdminDashboardControllerImp> {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة المنتجات والأصناف والطلبات')),
      body: GetBuilder<AdminDashboardControllerImp>(
        builder: (_) => HandlingDataView(
          state: controller.stateRequest,
          child: RefreshIndicator(
            onRefresh: controller.refreshData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        CustomCardCount(
                          length: controller.totalProducts,
                          title: "Products",
                        ),
                        CustomCardCount(
                          length: controller.totalCategories,
                          title: "Categories",
                        ),
                        CustomCardCount(
                          length: controller.totalOrders,
                          title: "Orders",
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Divider(),
                    CustomCardManagement(
                      onTap: () {
                        controller.goToCategoriesPage();
                      },
                      title: 'Categories Management',
                      icon: Icons.category,
                    ),
                    CustomCardManagement(
                      onTap: () {
                        controller.goToProductsPage();
                      },
                      title: 'Products Management',
                      icon: Icons.shopping_bag,
                    ),
                    CustomCardManagement(
                      onTap: () {
                        controller.goToOrdersPage();
                      },
                      title: 'Orders Management',
                      icon: Icons.list_alt,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
