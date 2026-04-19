import 'package:dartz/dartz.dart';
import 'package:purchase_request_manager/constant/api_endpoints.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/services/api_service.dart';

class DashboardData {
  ApiService apiService;
  DashboardData(this.apiService);

  Future<Either<StateRequest, Map<String, dynamic>>> getDashboardData() async {
    final result = await apiService.get(ApiEndpoints.dashboard);
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
