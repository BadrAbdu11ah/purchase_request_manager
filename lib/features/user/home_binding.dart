import 'package:get/get.dart';
import 'package:purchase_request_manager/features/user/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeControllerImp());
  }
}
