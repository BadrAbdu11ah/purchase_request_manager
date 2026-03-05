import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/features/user/auth/controller/register_controller.dart';
import 'package:purchase_request_manager/core/class/handling_data_view.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إنشاء حساب جديد')),
      body: GetBuilder<RegisterController>(
        builder: (controller) => HandlingDataView(
          state: controller.stateRequest,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    labelText: 'الاسم الكامل',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'كلمة المرور',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
                const SizedBox(height: 30),
                MaterialButton(
                  minWidth: double.infinity,
                  color: Colors.teal,
                  textColor: Colors.white,
                  onPressed: controller.register,
                  child: const Text('تأكيد التسجيل'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
