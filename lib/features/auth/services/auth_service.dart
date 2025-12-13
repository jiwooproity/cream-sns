import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Models
import 'package:cream_sns/features/auth/model/user.dart';

// Services
import 'package:cream_sns/core/services/api_client.dart';

final apiClientProvider = Provider((ref) => ApiClient());

final authRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRepository(apiClient);
});

class AuthRepository {
  final ApiClient _apiClient;
  late final Dio _dio = _apiClient.dio;

  AuthRepository(this._apiClient);

  Future<User> editProfile(FormData formData) async {
    final response = await _dio.patch(
      "/profile/edit",
      data: formData,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
    );
    return User.fromJson(response.data);
  }

  Future<User> me() async {
    await _apiClient.initCookie();
    final response = await _dio.get("/auth/me");
    return User.fromJson(response.data);
  }

  Future<User> login(String userId, String password) async {
    final response = await _dio.post(
      "/auth/login",
      data: {'userId': userId, 'password': password},
    );
    return User.fromJson(response.data);
  }

  Future<void> signUp(String userId, String nickname, String password) async {
    await _dio.post(
      "/auth/signup",
      data: {'userId': userId, 'nickname': nickname, "password": password},
    );
  }

  Future<Response<dynamic>> logout() async {
    final response = await _dio.post("/auth/logout");
    return response;
  }
}
