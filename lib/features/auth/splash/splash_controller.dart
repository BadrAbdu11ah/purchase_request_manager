import 'package:get/get.dart';
import 'package:purchase_request_manager/constant/app_route.dart';
import 'package:purchase_request_manager/features/auth/auth_controller.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';

class SplashController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  @override
  void onReady() {
    checkSession();
    super.onReady();
  }

  Future<void> checkSession() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = await authController.storage.read(key: 'token');
    print(" Token: $token"); // Debug print to check the token value
    if (token == null || token.isEmpty) {
      Get.offAllNamed(AppRoutesConst.login);
      return;
    }

    final meState = await authController.me();
    if (meState == StateRequest.success) {
      Get.offAllNamed(AppRoutesConst.home);
      return;
    }

    await authController.deleteAuthData();
    Get.offAllNamed(AppRoutesConst.login);
  }
}
