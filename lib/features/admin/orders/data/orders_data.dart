// ربط طبقة البيانات بالمتحكم لعمليات الطلبات
import 'package:dartz/dartz.dart';
import 'package:purchase_request_manager/constant/api_endpoints.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/model/category_model.dart';
import 'package:purchase_request_manager/model/order/order_model.dart';
import 'package:purchase_request_manager/model/order/paginated_orders.dart';
import 'package:purchase_request_manager/model/product_model.dart';
import 'package:purchase_request_manager/services/api_service.dart';

class OrdersData {
  ApiService apiService;
  OrdersData(this.apiService);

  Future<Either<StateRequest, PaginatedOrders>> getOrders(int page) async {
    final result = await apiService.get("${ApiEndpoints.orders}?page=$page");
    return result.fold((failure) => Left(failure), (response) {
      var paginationData = response['data'];
      List rawList = paginationData['data'] ?? [];
      final ordersList = rawList
          .map((item) => OrderModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return Right(
        PaginatedOrders(
          orders: ordersList,
          currentPage: paginationData['current_page'],
          lastPage: paginationData['last_page'],
          total: paginationData['total'],
        ),
      );
    });
  }

  Future<Either<StateRequest, OrderModel>> getOrderDetails(int orderId) async {
    final result = await apiService.get(ApiEndpoints.orderById(orderId));
    return result.fold(
      (failure) => Left(failure),
      (data) =>
          Right(OrderModel.fromJson(data['data'] as Map<String, dynamic>)),
    );
  }

  Future<Either<StateRequest, List<ProductModel>>> getProducts() async {
    final result = await apiService.get(ApiEndpoints.products);
    return result.fold(
      (failure) {
        return Left(failure);
      },
      (data) {
        final raw = (data['data'] ?? []) as List<dynamic>;
        final products = raw
            .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return Right(products);
      },
    );
  }

  Future<Either<StateRequest, List<CategoryModel>>> getCategories() async {
    final result = await apiService.get(ApiEndpoints.categories);
    return result.fold(
      (failure) {
        return Left(failure);
      },
      (data) {
        final raw = (data['data'] ?? []) as List<dynamic>;
        final categories = raw
            .map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return Right(categories);
      },
    );
  }

  Future<Either<StateRequest, void>> sendOrder(
    Map<String, dynamic> orderData,
  ) async {
    final result = await apiService.post(ApiEndpoints.storeOrder, orderData);
    return result.fold((failure) => Left(failure), (data) => Right(null));
  }

  Future<Either<StateRequest, void>> removeOrder(int orderId) async {
    final result = await apiService.delete(ApiEndpoints.orderDelete(orderId));
    return result.fold((failure) => Left(failure), (data) => Right(null));
  }
}
