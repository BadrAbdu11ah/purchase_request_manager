import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/core/class/handling_data_view.dart';
import 'package:purchase_request_manager/features/admin/orders/edit/edit_orders_controller.dart';
import 'package:purchase_request_manager/features/admin/orders/widgets/card_add_orders.dart';
import 'package:purchase_request_manager/features/admin/orders/widgets/order_summary_box.dart';

class AdminEditOrdersPage extends GetView<AdminEditOrdersControllerImp> {
  const AdminEditOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تعديل الطلب')),
      bottomNavigationBar: Container(
        // نستخدم padding خارجي لضمان عدم التصاق الحاوية بالحواف
        padding: EdgeInsets.only(
          // لرفع الحاوية عند ظهور لوحة المفاتيح
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 16,
          right: 16,
          top: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // حقل الملاحظات
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: TextField(
                // ربط الحقل بمتغير الملاحظات في المتحكم
                controller: controller.notesController,
                decoration: const InputDecoration(
                  hintText: 'أضف ملاحظة للطلب (اختياري)',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // زر إرسال الطلب
            MaterialButton(
              height: 50,
              minWidth: double.infinity, // لجعل الزر يأخذ العرض بالكامل
              color: Colors.blue,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                controller.sendOrder(); // دالة الإرسال في المتحكم
              },
              child: const Text(
                'تعديل الطلب',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: GetBuilder<AdminEditOrdersControllerImp>(
        builder: (controller) => HandlingDataView(
          state: controller.stateRequest,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: controller.products.isEmpty
                ? const Center(child: Text('لا توجد منتجات متاحة'))
                : ListView(
                    children: [
                      // 1. مربع ملخص الطلب يظهر في الأعلى
                      OrderSummaryBox(
                        items: controller.selectedItems,
                        totalPrice: controller.totalEstimatedPrice,
                        // استدعاء دالة الحذف عند الضغط على الأيقونة
                        onRemove: (productId) {
                          controller.removeProduct(productId);
                        },
                      ),

                      const Text(
                        "اختر المنتجات من الأقسام أدناه:",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),

                      // 2. قائمة الأقسام والمنتجات
                      ...controller.categories.map((category) {
                        bool isSelected =
                            controller.selectedCategoryId == category.id;
                        return CardAddOrders(
                          isSelected: isSelected,
                          categoryName: category.name,
                          filteredProducts: controller.filteredProducts,
                          onCategoryTap: () =>
                              controller.selectCategory(category),
                          onProductTap: (product) {
                            controller.addOrUpdateProduct(product);
                          },
                        );
                      }),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
