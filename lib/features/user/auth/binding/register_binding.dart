import 'package:get/get.dart';
import 'package:purchase_request_manager/features/user/auth/controller/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
