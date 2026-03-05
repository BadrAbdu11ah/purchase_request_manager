import 'package:get/get.dart';
import 'package:purchase_request_manager/constant/app_route.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/features/admin/dashboard/dashboard_controller.dart';
import 'package:purchase_request_manager/features/admin/products/data/products_data.dart';
import 'package:purchase_request_manager/model/product_model.dart';
import 'package:purchase_request_manager/services/api_service.dart';

abstract class AdminProductsController extends GetxController {
  List<ProductModel> products = [];
  StateRequest stateRequest = StateRequest.none;
  final ProductsData productsData = ProductsData(Get.find<ApiService>());

  Future<void> loadProducts();
  void goToAddProductPage();
  void goToEditProductPage(ProductModel product);
  Future<void> deleteProduct(int id);
  Future<void> refreshData();
}

class AdminProductsControllerImp extends AdminProductsController {
  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  @override
  Future<void> refreshData() {
    stateRequest = StateRequest.loading;
    update();
    return loadProducts();
  }

  @override
  Future<void> loadProducts() async {
    final result = await productsData.getProducts();
    result.fold((failure) => stateRequest = failure, (data) {
      stateRequest = StateRequest.success;
      products = data;
    });
    update();
  }

  @override
  Future<void> deleteProduct(int id) async {
    products.removeWhere((product) => product.id == id);
    update();
    final result = await productsData.removeProduct(id);

    result.fold(
      (_) {
        Get.snackbar(
          'error',
          'error deleting product',
          snackPosition: SnackPosition.BOTTOM,
        );
        stateRequest = StateRequest.failure;
        update();
      },
      (_) async {
        AdminDashboardControllerImp dashboardController = Get.find();
        dashboardController.products--;
        dashboardController.update();
        Get.snackbar(
          'نجاح',
          'تم حذف الصنف بنجاح',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  @override
  void goToAddProductPage() {
    Get.toNamed(AppRoutesConst.adminAddProduct);
  }

  @override
  void goToEditProductPage(ProductModel product) {
    Get.toNamed(AppRoutesConst.adminEditProduct, arguments: product);
  }
}
