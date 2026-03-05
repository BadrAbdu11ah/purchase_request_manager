import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:purchase_request_manager/core/class/state_request.dart';
import 'package:purchase_request_manager/core/function/check_internet.dart';

class ApiService {
  final String baseUrl;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  ApiService({required this.baseUrl});

  Future<String?> getToken() async => storage.read(key: 'token');

  Future<Map<String, String>> _getHeaders({bool auth = true}) async {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    if (auth) {
      final token = await getToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  Future<Either<StateRequest, Map<String, dynamic>>> get(
    String endpoint, {
    bool auth = true,
  }) async {
    try {
      if (!await checkInternet()) {
        return const Left(StateRequest.offlinefailure);
      }
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = await _getHeaders(auth: auth);
      final response = await http.get(url, headers: headers);
      print("=========== API GET Request ===========");
      print("respondense: ${response.statusCode} - ${response.body}");
      return _handleResponse(response);
    } catch (_) {
      return const Left(StateRequest.serverfailure);
    }
  }

  Future<Either<StateRequest, Map<String, dynamic>>> post(
    String endpoint,
    Map<String, dynamic> body, {
    bool auth = true,
  }) async {
    try {
      if (!await checkInternet()) {
        return const Left(StateRequest.offlinefailure);
      }
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = await _getHeaders(auth: auth);
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      print("=========== API POST Request ===========");
      print("respondense: ${response.statusCode} - ${response.body}");
      return _handleResponse(response);
    } catch (e) {
      print("Error in POST request: $e");
      return const Left(StateRequest.serverfailure);
    }
  }

  Future<Either<StateRequest, Map<String, dynamic>>> put(
    String endpoint,
    Map<String, dynamic> body, {
    bool auth = true,
  }) async {
    try {
      if (!await checkInternet()) {
        return const Left(StateRequest.offlinefailure);
      }
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = await _getHeaders(auth: auth);
      final response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (_) {
      return const Left(StateRequest.serverfailure);
    }
  }

  Future<Either<StateRequest, Map<String, dynamic>>> delete(
    String endpoint, {
    bool auth = true,
  }) async {
    try {
      if (!await checkInternet()) {
        return const Left(StateRequest.offlinefailure);
      }
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = await _getHeaders(auth: auth);
      final response = await http.delete(url, headers: headers);
      return _handleResponse(response);
    } catch (_) {
      return const Left(StateRequest.serverfailure);
    }
  }

  Either<StateRequest, Map<String, dynamic>> _handleResponse(
    http.Response response,
  ) {
    final code = response.statusCode;
    if (code == 200 || code == 201) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        return Right(decoded);
      }
      return const Left(StateRequest.noData);
    }
    return const Left(StateRequest.failure);
  }
}
