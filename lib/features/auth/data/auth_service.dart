import 'package:cream_sns/features/auth/model/session.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dio
import 'package:cream_sns/core/network/dio_instance.dart';

// Models
import 'package:cream_sns/features/auth/model/user.dart';

final authClientProvider = Provider((ref) {
  final dioInstance = ref.watch(dioProvider);
  return AuthClient(dioInstance);
});

class AuthClient {
  AuthClient(this._dio);

  final DioInstance _dio;

  Future<Session> edit(FormData formData) async {
    final response = await _dio.patch(path: "/profile/edit", data: formData);
    return Session.fromJson(response.data);
  }

  Future<Session> me() async {
    await _dio.initCookie();
    final response = await _dio.get("/auth/me");
    return Session.fromJson(response.data);
  }

  Future<Session> login(String userId, String password) async {
    final response = await _dio.post(
      path: "/auth/login",
      data: {'userId': userId, 'password': password},
    );

    return Session.fromJson(response.data);
  }

  Future<void> signUp(String userId, String nickname, String password) async {
    await _dio.post(
      path: "/auth/signup",
      data: {'userId': userId, 'nickname': nickname, "password": password},
    );
  }

  Future<Response<dynamic>> logout() async {
    return await _dio.post(path: "/auth/logout");
  }
}
