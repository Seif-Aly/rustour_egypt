import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/auth_response.dart';
import '../models/user.dart';
import 'api_client.dart';

class AuthService {
  final Dio _dio = ApiClient().dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const _jwtKey = 'jwtToken';

  AuthService._();
  static final AuthService _instance = AuthService._();
  factory AuthService() => _instance;

  Future<User> login(String email, String password) async {
    final res = await _dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    final token = (res.data as Map<String, dynamic>)['token'] as String;
    await _storage.write(key: _jwtKey, value: token);

    final meRes = await _dio.get('/Users/me');
    return User.fromJson(meRes.data as Map<String, dynamic>);
  }

  Future<User> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final res = await _dio.post(
      '/auth/register',
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      },
    );

    final authRes = AuthResponse.fromJson(res.data as Map<String, dynamic>);

    await _storage.write(key: _jwtKey, value: authRes.token);

    return authRes.user;
  }
}
