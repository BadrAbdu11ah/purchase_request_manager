import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/features/user/auth/view/splash_page.dart';

void main() {
  testWidgets('Splash screen renders app title', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(home: SplashView()));

    expect(find.text('Purchase Request Manager'), findsOneWidget);
    expect(find.byIcon(Icons.shopping_cart_checkout), findsOneWidget);
  });
}
