import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:purchase_request_manager/constant/api_endpoints.dart';
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/services/api_service.dart';

class AuthController extends GetxController {
  final ApiService api = Get.find<ApiService>();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  late StateRequest stateRequest;

  Map<String, dynamic> user = {};

  String get role => user['role']?.toString() ?? '';
  bool get canManageInventory => role == 'store_keeper';

  Future<void> saveAuthData(Map<String, dynamic> data) async {
    final token = data['token']?.toString();
    if (token != null && token.isNotEmpty) {
      await storage.write(key: 'token', value: token);
    }

    final userData = data['data'];
    if (userData is Map<String, dynamic>) {
      user = userData;
    }

    update();
  }

  Future<void> deleteAuthData() async {
    await storage.delete(key: 'token');
    user = {};
    update();
  }

  Future<StateRequest> login({
    required String email,
    required String password,
  }) async {
    final response = await api.post(ApiEndpoints.login, {
      'email': email.trim(),
      'password': password,
    }, auth: false);

    await response.fold(
      (failure) async {
        stateRequest = failure;
      },
      (data) async {
        await saveAuthData(data);
        stateRequest = StateRequest.success;
      },
    );

    return stateRequest;
  }

  Future<StateRequest> register({
    required String name,
    required String email,
    required String password,
    String? role,
  }) async {
    final body = <String, dynamic>{
      'name': name.trim(),
      'email': email.trim(),
      'password': password,
    };

    if (role != null && role.isNotEmpty) {
      body['role'] = role;
    }

    final response = await api.post(ApiEndpoints.register, body, auth: false);
    print('Register Response: $response'); // Debug print to check the response

    await response.fold(
      (failure) async {
        stateRequest = failure;
      },
      (data) async {
        await saveAuthData(data);
        stateRequest = StateRequest.success;
      },
    );

    return stateRequest;
  }

  Future<StateRequest> me() async {
    final response = await api.get(ApiEndpoints.me);
    print(' Me Response: $response'); // Debug print to check the response
    response.fold(
      (failure) {
        stateRequest = failure;
      },
      (data) {
        final userData = data['data'];
        if (userData is Map<String, dynamic>) {
          user = userData;
        }
        stateRequest = StateRequest.success;
      },
    );

    update();
    return stateRequest;
  }

  Future<StateRequest> logout() async {
    final response = await api.post(ApiEndpoints.logout, {});
    response.fold(
      (failure) {
        stateRequest = failure;
      },
      (_) {
        stateRequest = StateRequest.success;
      },
    );

    await deleteAuthData();
    return stateRequest;
  }
}
