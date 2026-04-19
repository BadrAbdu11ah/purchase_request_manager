import 'package:flutter/material.dart';
import 'package:purchase_request_manager/model/product_model.dart';

class CardAddOrders extends StatelessWidget {
  final bool isSelected;
  final String categoryName;
  final List<ProductModel> filteredProducts;
  final void Function() onCategoryTap;
  final void Function(ProductModel product) onProductTap;

  const CardAddOrders({
    super.key,
    required this.isSelected,
    required this.categoryName,
    required this.onCategoryTap,
    required this.filteredProducts,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    // إزالة الارتفاع الثابت (height: 100) ليتمكن الـ Container من التمدد
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100], // لون خفيف للخلفية بدلاً من الرمادي الغامق
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // يجعل العمود يأخذ مساحة المحتوى فقط
        children: [
          // بطاقة القسم الرئيسية
          Card(
            margin: EdgeInsets.zero,
            color: isSelected ? Colors.blue : Colors.white,
            elevation: isSelected ? 3 : 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              onTap: onCategoryTap,
              title: Text(
                categoryName,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              trailing: Icon(
                isSelected
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
          ),

          // عرض المنتجات فقط في حالة التفعيل
          if (isSelected)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: filteredProducts.isEmpty
                  ? const ListTile(title: Text("لا توجد منتجات في هذا القسم"))
                  : Column(
                      // استخدام Column هنا لأن الأب ListView يوفر التمرير بالفعل
                      children: filteredProducts.map((product) {
                        return ListTile(
                          title: Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text("السعر: ${product.price}"),
                          trailing: IconButton(
                            onPressed: () => onProductTap(product),
                            icon: Icon(Icons.add),
                          ),
                        );
                      }).toList(),
                    ),
            ),
        ],
      ),
    );
  }
}
