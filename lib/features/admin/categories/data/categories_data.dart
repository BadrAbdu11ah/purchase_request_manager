import 'package:dartz/dartz.dart';
import 'package:purchase_request_manager/constant/api_endpoints.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/model/category_model.dart';
import 'package:purchase_request_manager/services/api_service.dart';

class CategoriesData {
  ApiService apiService;
  CategoriesData(this.apiService);

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

  Future<Either<StateRequest, CategoryModel>> addCategories(String name) async {
    final result = await apiService.post(ApiEndpoints.categoryStore, {
      'name': name.trim(),
    });
    return result.fold(
      (failure) {
        return Left(failure);
      },
      (data) {
        final raw = (data['data'] ?? "");
        final categories = CategoryModel.fromJson(raw as Map<String, dynamic>);
        return Right(categories);
      },
    );
  }

  Future<Either<StateRequest, CategoryModel>> editCategories(
    int id,
    String name,
  ) async {
    final result = await apiService.post(ApiEndpoints.categoryUpdate(id), {
      'name': name.trim(),
    });

    return result.fold(
      (failure) {
        return Left(failure);
      },
      (data) {
        final raw = (data['data'] ?? "");
        final categories = CategoryModel.fromJson(raw as Map<String, dynamic>);
        return Right(categories);
      },
    );
  }

  Future<Either<StateRequest, Map<String, dynamic>>> removeCategory(
    int id,
  ) async {
    final result = await apiService.delete(ApiEndpoints.categoryDelete(id));
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
