import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/constant/app_route.dart';
import 'package:purchase_request_manager/features/auth/auth_controller.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';

class RegisterController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  StateRequest stateRequest = StateRequest.none;

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  Future<void> register() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar('تنبيه', 'يرجى ملء جميع الحقول');
      return;
    }

    stateRequest = StateRequest.loading;
    update();

    final result = await authController.register(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    print("============================================");
    print('Register result: $result');
    print("============================================");

    if (result != StateRequest.success) {
      stateRequest = StateRequest.none;
      update();
      Get.snackbar('خطأ', 'فشل إنشاء الحساب');
      return;
    }

    final meState = await authController.me();
    if (meState != StateRequest.success) {
      stateRequest = StateRequest.none;
      update();
      Get.snackbar('خطأ', 'فشل تحميل بيانات المستخدم');
      return;
    }

    stateRequest = StateRequest.success;
    update();
    Get.offAllNamed(AppRoutesConst.home);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
