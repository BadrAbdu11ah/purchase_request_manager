import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/features/user/auth/auth_controller.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/model/order_model.dart';
import 'package:purchase_request_manager/model/product_model.dart';
import 'package:purchase_request_manager/services/order_service.dart';

class OrdersController extends GetxController {
  final OrderService orderService;
  OrdersController({required this.orderService});

  final authController = Get.find<AuthController>();

  StateRequest stateRequest = StateRequest.none;

  // قوائم البيانات
  List<OrderModel> orders = [];
  List<ProductModel> products = [];

  bool submittingOrder = false;

  final TextEditingController notesController = TextEditingController();
  final Map<int, TextEditingController> quantityControllers = {};

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  Future<void> refreshData() async {
    await loadProducts();
    await loadOrders();
  }

  Future<void> loadProducts() async {
    stateRequest = StateRequest.loading;
    update();

    final result = await orderService.getProducts();
    result.fold(
      (failure) {
        stateRequest = failure;
      },
      (data) {
        stateRequest = StateRequest.success;
        products = data;
        _initQuantityControllers();
      },
    );
    update();
  }

  Future<void> loadOrders() async {
    stateRequest = StateRequest.loading;
    update();

    final result = await orderService.getOrders();
    result.fold(
      (failure) {
        stateRequest = failure;
      },
      (data) {
        stateRequest = StateRequest.success;
        orders = data;
      },
    );
    update();
  }

  // خاص بإضاقة طلب جديد من خلال الفورم
  Future<void> submitOrderFromForm() async {
    final items = _collectItems();

    if (items.isEmpty) {
      Get.snackbar('تنبيه', 'يرجى إدخال كمية لمنتج واحد على الأقل');
      return;
    }

    submittingOrder = true;
    update();

    final result = await orderService.createOrder(
      notes: notesController.text.trim().isEmpty
          ? null
          : notesController.text.trim(),
      items: items,
    );

    result.fold(
      (failure) {
        submittingOrder = false;
        Get.snackbar('خطأ', 'فشل إنشاء الطلب');
      },
      (success) {
        submittingOrder = false;
        Get.back(); // إغلاق الديالوج
        loadOrders(); // تحديث القائمة
        Get.snackbar('نجاح', 'تم إرسال الطلب بنجاح');
      },
    );
    update();
  }

  // دالة تحديث الحالة (لمسؤول المشتريات)
  Future<void> updateStatus(int id, String status) async {
    // هنا لا نغير stateRequest الصفحة كاملة، بل نكتفي بإظهار تحميل بسيط أو سناك بار
    final result = await orderService.updateStatus(id: id, status: status);

    result.fold((failure) => Get.snackbar('خطأ', 'فشل تحديث الحالة'), (
      success,
    ) {
      loadOrders(); // إعادة جلب البيانات لتعكس الحالة الجديدة
      Get.snackbar('تحديث', 'تم تغيير الحالة إلى $status');
    });
  }

  // --- دوال مساعدة (Helper Functions) ---

  // دالة لتجهيز متحكمات النصوص لكل منتج في القائمة
  void _initQuantityControllers() {
    // الدوران على كل المنتجات القادمة من قاعدة البيانات
    for (final product in products) {
      // التأكد من وجود متحكم لكل منتج دون مسح البيانات القديمة
      quantityControllers.putIfAbsent(
        product.id, // المفتاح هو رقم المنتج الفريد
        () => TextEditingController(), // القيمة هي إنشاء متحكم نصي جديد
      );
    }
  }

  List<Map<String, dynamic>> _collectItems() {
    // 1. إنشاء قائمة فارغة لتخزين المنتجات المختارة فقط
    final items = <Map<String, dynamic>>[];

    // 2. الدوران على كل "المدخلات" الموجودة في القاموس
    for (final entry in quantityControllers.entries) {
      // 3. محاولة تحويل النص المكتوب إلى رقم عشري
      final quantity = double.tryParse(entry.value.text.trim());

      // 4. الفلترة: هل الرقم صالح وأكبر من صفر؟
      if (quantity != null && quantity > 0) {
        // 5. إضافة معرف المنتج والكمية إلى القائمة النهائية
        items.add({'product_id': entry.key, 'quantity': quantity});
      }
    }
    return items; // إرسال القائمة الجاهزة للطلب
  }

  @override
  void onClose() {
    notesController.dispose();
    for (final controller in quantityControllers.values) {
      controller.dispose();
    }
    super.onClose();
  }
}
