// مربع معاينة المنتجات المختارة قبل الإرسال
import 'package:flutter/material.dart';

class OrderSummaryBox extends StatelessWidget {
  final List<dynamic> items; // قائمة تحتوي على Maps
  final double totalPrice;
  final void Function(int productId) onRemove; // دالة لحذف منتج من الملخص

  const OrderSummaryBox({
    super.key,
    required this.items,
    required this.totalPrice,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.shopping_cart_checkout, color: Colors.blue),
              SizedBox(width: 10),
              Text(
                "ملخص الطلب",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const Divider(),
          // استخدام الحلقة لعرض البيانات من الـ Map
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر الحذف الصغير
                  InkWell(
                    onTap: () => onRemove(item['product_id']),
                    child: const Icon(
                      Icons.remove_circle_outline,
                      color: Colors.redAccent,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "${item['productName']} (x${item['quantity']})",
                    ),
                  ),
                  Text("${item['price'] * item['quantity']} ريال"),
                ],
              ),
            ),
          ),
          const Divider(),
          // عرض الإجمالي بالريال السعودي والدولار
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "الإجمالي التقديري:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // القيمة الإجمالية بالريال
                  Text(
                    "${totalPrice.toStringAsFixed(2)} ريال سعودي",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  // تحويل القيمة إلى دولار (تقريباً 3.75)
                  Text(
                    "${(totalPrice / 3.75).toStringAsFixed(2)} \$",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
