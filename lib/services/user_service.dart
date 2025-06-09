import 'package:dio/dio.dart';
import '../models/user.dart';
import '../models/update_user_request.dart';
import 'api_client.dart';

class UserService {
  final Dio _dio = ApiClient().dio;

  Future<User> getMe() async {
    final res = await _dio.get('/Users/me');
    return User.fromJson(res.data);
  }

  Future<void> updateMe(UpdateUserRequest req) async {
    await _dio.put('/Users/me', data: req.toJson());
  }
}
