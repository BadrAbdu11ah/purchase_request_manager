import 'package:dartz/dartz.dart';
import 'package:purchase_request_manager/constant/api_endpoints.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/model/product_model.dart';
import 'package:purchase_request_manager/services/api_service.dart';

class ProductsData {
  ApiService apiService;
  ProductsData(this.apiService);

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

  Future<Either<StateRequest, ProductModel>> addProduct(
    String name,
    int? categoryId,
    String unit,
    String minLimit,
  ) async {
    final result = await apiService.post(ApiEndpoints.productStore, {
      "category_id": categoryId?.toString(),
      "name": name,
      "unit": unit,
      "min_limit": minLimit,
    });
    return result.fold(
      (failure) {
        return Left(failure);
      },
      (data) {
        final raw = (data['data'] ?? "");
        final products = ProductModel.fromJson(raw as Map<String, dynamic>);
        return Right(products);
      },
    );
  }

  Future<Either<StateRequest, ProductModel>> editProducts(
    int id,
    String name,
    int? categoryId,
    String unit,
    String minLimit,
  ) async {
    final result = await apiService.post(ApiEndpoints.productUpdate(id), {
      'name': name.trim(),
      'category_id': categoryId?.toString(),
      'unit': unit.trim(),
      'min_limit': minLimit.trim(),
    });

    return result.fold(
      (failure) {
        return Left(failure);
      },
      (data) {
        final raw = (data['data'] ?? "");
        final products = ProductModel.fromJson(raw as Map<String, dynamic>);
        return Right(products);
      },
    );
  }

  Future<Either<StateRequest, Map<String, dynamic>>> removeProduct(
    int id,
  ) async {
    final result = await apiService.delete(ApiEndpoints.productDelete(id));
    return result.fold(
      (failure) {
        return Left(failure);
      },
      (data) {
        return Right(data);
      },
    );
  }
}
