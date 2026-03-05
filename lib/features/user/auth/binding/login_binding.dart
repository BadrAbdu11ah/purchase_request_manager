import 'package:get/get.dart';
import 'package:purchase_request_manager/features/user/auth/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
