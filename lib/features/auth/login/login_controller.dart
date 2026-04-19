import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/constant/app_route.dart';
import 'package:purchase_request_manager/features/auth/auth_controller.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';

class LoginController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  StateRequest stateRequest = StateRequest.none;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  Future<void> login() async {
    stateRequest = StateRequest.loading;
    update();

    final result = await authController.login(
      email: emailController.text,
      password: passwordController.text,
    );
    print("============================================");
    print('Login result: $result');
    print("============================================");

    if (result != StateRequest.success) {
      stateRequest = StateRequest.none;
      update();
      Get.snackbar('تنبيه', 'تأكد من بيانات تسجيل الدخول');
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
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
