import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/features/user/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings_outlined),
            onPressed: () {
              controller.goToAdminDashboard();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () {
              controller.logout();
            },
          ),
        ],
      ),
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
