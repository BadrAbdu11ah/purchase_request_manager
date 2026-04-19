import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/features/admin/orders/data/orders_data.dart';
import 'package:purchase_request_manager/features/admin/orders/page/orders_controller.dart';
import 'package:purchase_request_manager/model/category_model.dart';
import 'package:purchase_request_manager/model/product_model.dart';
import 'package:purchase_request_manager/services/api_service.dart';

abstract class AdminEditOrdersController extends GetxController {
  final OrdersData ordersData = OrdersData(Get.find<ApiService>());
  List<ProductModel> products = [];
  List<CategoryModel> categories = [];

  int? selectedCategoryId;
  // قائمة لتخزين المنتجات بعد تطبيق الفلترة حسب القسم المختار
  List<ProductModel> filteredProducts = [];

  // قائمة لتخزين المنتجات المختارة للطلب
  List<Map<String, dynamic>> selectedItems = [];
  // إجمالي السعر التقديري بالريال السعودي
  double totalEstimatedPrice = 0.0;

  late TextEditingController notesController;

  StateRequest stateRequest = StateRequest.none;
  Future<void> refreshData();
  Future<void> loadProducts();
  Future<void> loadCategories();

  // void loadOrderDetails(int orderId);
  void selectCategory(CategoryModel category);
  void addOrUpdateProduct(ProductModel product);
  void removeProduct(int productId);
  Future<void> sendOrder();
}

class AdminEditOrdersControllerImp extends AdminEditOrdersController {
  @override
  void onInit() {
    super.onInit();
    notesController = TextEditingController();
    refreshData();
  }

  @override
  Future<void> refreshData() async {
    stateRequest = StateRequest.loading;
    update();
    await loadProducts();
    if (stateRequest == StateRequest.success ||
        stateRequest == StateRequest.noData) {
      await loadCategories();
    }
    update();
  }

  @override
  Future<void> loadProducts() async {
    final result = await ordersData.getProducts();
    result.fold((failure) => stateRequest = failure, (data) {
      products = data;
      stateRequest = products.isEmpty
          ? StateRequest.noData
          : StateRequest.success;
    });
  }

  @override
  Future<void> loadCategories() async {
    final result = await ordersData.getCategories();
    result.fold((failure) => stateRequest = failure, (data) {
      categories = data;
      if (!categories.any((element) => element.id == -1)) {
        categories.add(CategoryModel(id: -1, name: "بدون تصنيف"));
      }
    });
  }

  @override
  void selectCategory(category) {
    // 1. منطق التبديل (Toggle): إذا ضغطت على المفعل سابقاً، قم بإلغائه
    if (selectedCategoryId == category.id) {
      selectedCategoryId = null;
      filteredProducts = [];
    } else {
      // 2. تفعيل القسم الجديد وتصفية المنتجات
      selectedCategoryId = category.id;

      if (category.id == -1) {
        // فلترة المنتجات التي ليس لها قسم (أو قسمها null)
        filteredProducts = products
            .where((p) => p.categoryId == null || p.categoryId == 0)
            .toList();
      } else {
        // فلترة المنتجات حسب معرف القسم
        filteredProducts = products
            .where((p) => p.categoryId == category.id)
            .toList();
      }
    }

    // 3. تحديث الواجهة
    update();
  }

  @override
  void addOrUpdateProduct(product) {
    // 1. البحث عن المنتج في القائمة الحالية باستخدام معرفه
    int index = selectedItems.indexWhere(
      (item) => item['product_id'] == product.id,
    );

    if (index != -1) {
      // 2. في حالة وجود المنتج، قم بزيادة الكمية فقط
      selectedItems[index]['quantity'] += 1;
    } else {
      // 3. في حالة المنتج الجديد، أضف بياناته إلى القائمة
      selectedItems.add({
        'product_id': product.id,
        'productName': product.name, // للعرض في واجهة الملخص
        'price': product.price, // السعر الفردي بالريال
        'quantity': 1,
      });
    }

    // 4. تحديث إجمالي السعر التقديري (بالريال والدولار)
    calculateTotal();

    // 5. تحديث الواجهة (UI) ليعكس المربع العلوي التغييرات فوراً
    update();
  }

  void calculateTotal() {
    totalEstimatedPrice = 0;
    for (var item in selectedItems) {
      // حساب السعر بناءً على الكمية × السعر المخزن بالريال
      totalEstimatedPrice += (item['price'] * item['quantity']);
    }
  }

  @override
  void removeProduct(productId) {
    // 1. البحث عن المنتج في القائمة
    int index = selectedItems.indexWhere(
      (item) => item['product_id'] == productId,
    );

    if (index != -1) {
      if (selectedItems[index]['quantity'] > 1) {
        // 2. إذا كانت الكمية أكثر من 1، قم بتقليلها
        selectedItems[index]['quantity'] -= 1;
      } else {
        // 3. إذا كانت الكمية 1، قم بحذف العنصر نهائياً
        selectedItems.removeAt(index);
      }

      // 4. إعادة حساب الإجمالي وتحديث الواجهة
      calculateTotal();
      update();
    }
  }

  @override
  Future<void> sendOrder() async {
    // 1. تحديث الحالة إلى "جاري التحميل"
    stateRequest = StateRequest.loading;
    update();

    // 2. بناء قائمة العناصر المطلوبة (ID والكمية فقط)
    List<Map<String, dynamic>> orderItems = selectedItems.map((item) {
      return {'product_id': item['product_id'], 'quantity': item['quantity']};
    }).toList();

    // 3. إرسال البيانات إلى الـ API عبر ordersData
    final result = await ordersData.sendOrder({
      'items': orderItems,
      'notes': notesController.text.trim().isEmpty
          ? null
          : notesController.text,
    });

    // 4. معالجة النتيجة باستخدام fold (فشل | نجاح)
    return result.fold(
      (failure) {
        // في حالة الفشل: عرض تنبيه وتغيير الحالة
        Get.snackbar('خطأ', 'فشل في إرسال الطلب، يرجى المحاولة لاحقاً');
        stateRequest = StateRequest.none;
        update();
      },
      (response) async {
        // في حالة النجاح:
        Get.back(); // العودة لواجهة الطلبات أو القائمة الرئيسية
        Get.snackbar('نجاح', 'تم إرسال الطلب بنجاح');

        // 5. تصفير البيانات الحالية بعد نجاح الإرسال
        selectedItems.clear();
        calculateTotal(); // تصفير الإجمالي (بالريال)
        notesController.clear(); // مسح حقل الملاحظات

        // تحديث الحالة النهائية للواجهة
        stateRequest = StateRequest.success;
        update();

        // ملاحظة: يمكنك هنا تحديث قائمة الطلبات في كنترولر آخر إذا وجد
        AdminOrdersControllerImp ordersController = AdminOrdersControllerImp();
        ordersController.refresh();
      },
    );
  }
}
