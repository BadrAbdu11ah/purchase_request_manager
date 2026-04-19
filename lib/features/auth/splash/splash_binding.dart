import 'package:get/get.dart';
import 'package:purchase_request_manager/features/auth/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
