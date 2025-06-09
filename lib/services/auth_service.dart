import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/auth_response.dart';
import '../models/user.dart';

const _baseUrl = 'http://10.0.2.2:5281/api/auth';
const _jwtKey = 'jwtToken';

class AuthService {
  AuthService._() {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
  }
  static final AuthService _instance = AuthService._();
  factory AuthService() => _instance;

  late final Dio _dio;
  final _storage = const FlutterSecureStorage();

  /// Logs in, stores token, and returns the User object
  Future<User> login(String email, String password) async {
    final res = await _dio.post(
      '/login',
      data: {'email': email, 'password': password},
    );

    // Deserialize
    final authRes = AuthResponse.fromJson(res.data as Map<String, dynamic>);

    // Persist token
    await _storage.write(key: _jwtKey, value: authRes.token);

    // Return the fully-typed User
    return authRes.user;
  }
}
