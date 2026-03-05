import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/app_route.dart';
import 'package:purchase_request_manager/app/app_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Purchase Request Manager',
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      getPages: AppRoute.routes,
      initialRoute: '/',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
    );
  }
}
