import 'package:get/get.dart';
import 'package:purchase_request_manager/constant/api_endpoints.dart';
import 'package:purchase_request_manager/features/user/auth/auth_controller.dart';
import 'package:purchase_request_manager/services/api_service.dart';
import 'package:purchase_request_manager/services/order_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ApiService>(ApiService(baseUrl: ApiEndpoints.baseUrl));
    Get.put<AuthController>(AuthController());
    Get.put<OrderService>(OrderService(apiService: Get.find<ApiService>()));
  }
}
