import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:purchase_request_manager/constant/api_endpoints.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/model/order_model.dart';
import 'package:purchase_request_manager/model/product_model.dart';
import 'package:purchase_request_manager/services/api_service.dart';

class OrderService {
  final ApiService apiService;

  OrderService({required this.apiService});

  Future<Either<StateRequest, List<ProductModel>>> getProducts() async {
    final result = await apiService.get(ApiEndpoints.products);
    return result.fold((_) => Left(StateRequest.noData), (data) {
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

  Future<Either<StateRequest, OrderModel>> createOrder({
    String? notes,
    required List<Map<String, dynamic>> items,
  }) async {
    final body = {'notes': notes, 'items': items};

    final result = await apiService.post(ApiEndpoints.storeOrder, body);
    return result.fold(
      Left.new,
      (data) =>
          Right(OrderModel.fromJson(data['data'] as Map<String, dynamic>)),
    );
  }

  Future<Either<StateRequest, OrderModel>> getOrderById(int id) async {
    final result = await apiService.get(ApiEndpoints.orderById(id));
    return result.fold(
      Left.new,
      (data) =>
          Right(OrderModel.fromJson(data['data'] as Map<String, dynamic>)),
    );
  }

  Future<Either<StateRequest, OrderModel>> updateStatus({
    required int id,
    required String status,
  }) async {
    final result = await apiService.post(ApiEndpoints.updateOrderStatus(id), {
      'status': status,
    });
    return result.fold(
      Left.new,
      (data) =>
          Right(OrderModel.fromJson(data['data'] as Map<String, dynamic>)),
    );
  }
}
