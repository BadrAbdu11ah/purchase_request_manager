import 'package:get/get.dart';
import 'package:purchase_request_manager/features/auth/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
