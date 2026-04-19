import 'package:get/get.dart';
import 'package:purchase_request_manager/constant/app_route.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/features/auth/auth_controller.dart';

abstract class HomeController extends GetxController {
  AuthController authController = Get.find<AuthController>();
  StateRequest stateRequest = StateRequest.none;

  void goToAdminDashboard();
  Future<void> logout();
}

class HomeControllerImp extends HomeController {
  @override
  void goToAdminDashboard() {
    Get.offAllNamed(AppRoutesConst.adminDashboard);
  }

  @override
  Future<void> logout() async {
    stateRequest = StateRequest.loading;
    update();

    final result = await authController.logout();

    if (result != StateRequest.success) {
      stateRequest = StateRequest.none;
      update();
      Get.snackbar('تنبيه', 'فشل تسجيل الخروج');
      return;
    }

    stateRequest = StateRequest.success;
    update();
    Get.offAllNamed(AppRoutesConst.splash);
  }
}
