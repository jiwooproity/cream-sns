import "package:cream_sns/features/auth/model/user.dart";
import "package:dio/dio.dart";
import "package:flutter_riverpod/legacy.dart";

import "package:cream_sns/features/auth/services/auth_service.dart";

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((
  ref,
) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthStateNotifier(repository);
});

class AuthState {
  final User? user;
  final bool isLoading;

  const AuthState({this.user, this.isLoading = true});

  AuthState copyWith({User? user, bool? isLoading}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool get isAuthenticated => user != null;
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthStateNotifier(this._repository) : super(const AuthState());

  Future<bool> me() async {
    try {
      final response = await _repository.me();
      state = state.copyWith(user: response, isLoading: false);
      return true;
    } on DioException catch (e) {
      state = state.copyWith(isLoading: false);
      return false;
    }
  }

  Future<void> login(String userId, String password) async {
    try {
      final response = await _repository.login(userId, password);
      state = state.copyWith(user: response, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(isLoading: false);
      return e.response?.data['message'];
    }
  }

  Future<String> logout() async {
    final response = await _repository.logout();
    state = const AuthState();
    return response;
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
