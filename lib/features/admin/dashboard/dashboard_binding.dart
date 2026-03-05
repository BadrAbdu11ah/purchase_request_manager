import 'package:get/get.dart';
import 'package:purchase_request_manager/features/admin/dashboard/dashboard_controller.dart';

class AdminDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminDashboardControllerImp>(
      () => AdminDashboardControllerImp(),
    );
  }
}
