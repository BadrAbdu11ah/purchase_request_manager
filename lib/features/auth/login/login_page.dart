import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/features/auth/login/login_controller.dart';
import 'package:purchase_request_manager/core/class/handling_data_view.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(
        builder: (controller) => HandlingDataView(
          state: controller.stateRequest,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'تسجيل الدخول',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'كلمة المرور',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 30),
                MaterialButton(
                  minWidth: double.infinity,
                  color: Colors.teal,
                  textColor: Colors.white,
                  onPressed: controller.login,
                  child: const Text('دخول'),
                ),
                TextButton(
                  onPressed: () => Get.toNamed('/register'),
                  child: const Text('لا تملك حسابًا؟ سجل الآن'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
