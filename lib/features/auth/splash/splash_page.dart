import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/features/auth/splash/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_checkout, size: 90, color: Colors.teal),
            SizedBox(height: 20),
            Text(
              'Purchase Request Manager',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
