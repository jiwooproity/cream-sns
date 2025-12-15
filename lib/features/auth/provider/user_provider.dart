import "package:dio/dio.dart";
import "package:flutter_riverpod/legacy.dart";

// Models
import "package:cream_sns/features/auth/model/user.dart";

// Service
import "package:cream_sns/features/auth/services/user_service.dart";

final userStateProvider = StateNotifierProvider<UserStateNotifier, AuthState>((
  ref,
) {
  final repository = ref.watch(userClientProvider);
  return UserStateNotifier(repository);
});

class AuthState {
  const AuthState({this.user});

  final User? user;

  AuthState copyWith({User? user}) {
    return AuthState(user: user ?? this.user);
  }

  bool get isAuthenticated => user != null;
}

class UserStateNotifier extends StateNotifier<AuthState> {
  final UserClient _repository;

  UserStateNotifier(this._repository) : super(const AuthState());

  Future<void> edit(FormData formData) async {
    try {
      final response = await _repository.edit(formData);
      state = state.copyWith(user: response);
    } on DioException catch (e) {
      state = state.copyWith();
    }
  }

  Future<bool> me() async {
    try {
      final response = await _repository.me();
      state = state.copyWith(user: response);
      return true;
    } on DioException catch (e) {
      state = const AuthState();
      return false;
    }
  }

  Future<void> login(String userId, String password) async {
    try {
      final response = await _repository.login(userId, password);
      state = state.copyWith(user: response);
    } on DioException catch (e) {
      state = state.copyWith();
      return e.response?.data['message'];
    }
  }

  Future<Response<dynamic>> logout() async {
    return await _repository.logout();
  }

  Future<String?> signUp(
    String userId,
    String nickname,
    String password,
  ) async {
    try {
      await _repository.signUp(userId, nickname, password);
      return null;
    } on DioException catch (e) {
      return e.response?.data['message'];
    }
  }
}
