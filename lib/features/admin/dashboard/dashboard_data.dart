import 'package:dartz/dartz.dart';
import 'package:purchase_request_manager/constant/api_endpoints.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/model/category_model.dart';
import 'package:purchase_request_manager/model/order_model.dart';
import 'package:purchase_request_manager/model/product_model.dart';
import 'package:purchase_request_manager/services/api_service.dart';

class DashboardData {
  ApiService apiService;
  DashboardData(this.apiService);

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

  Future<Either<StateRequest, List<ProductModel>>> getProducts() async {
    final result = await apiService.get(ApiEndpoints.products);
    return result.fold((failure) => Left(failure), (data) {
      final raw = (data['data'] ?? []) as List<dynamic>;
      final products = raw
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
      return Right(products);
    });
  }

  Future<Either<StateRequest, List<OrderModel>>> getOrders() async {
    final result = await apiService.get(ApiEndpoints.orders);
    return result.fold((failure) => Left(failure), (data) {
      final raw = (data['data'] ?? []) as List<dynamic>;
      final orders = raw
          .map((item) => OrderModel.fromJson(item as Map<String, dynamic>))
          .toList();
      return Right(orders);
    });
  }
}
