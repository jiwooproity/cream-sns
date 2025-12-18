import "package:dio/dio.dart";
import "package:flutter_riverpod/legacy.dart";

// Data
import "package:cream_sns/features/auth/data/auth_service.dart";

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((
  ref,
) {
  final client = ref.watch(authClientProvider);
  return AuthStateNotifier(client);
});

class AuthState {
  const AuthState({
    this.userId,
    this.isAuthenticated = false,
    this.isLoading = false,
  });

  final String? userId;
  final bool isAuthenticated;
  final bool? isLoading;

  AuthState copyWith({String? userId, bool? isAuthenticated, bool? isLoading}) {
    return AuthState(
      userId: userId ?? this.userId,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier(this._user) : super(const AuthState());

  final AuthClient _user;

  void setLoading() {
    state = state.copyWith(isLoading: true);
  }

  Future<void> edit(FormData formData) async {
    try {
      await _user.edit(formData);
      state = state.copyWith(isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> me() async {
    try {
      final response = await _user.me();
      state = state.copyWith(userId: response.id, isAuthenticated: true);
    } on DioException catch (e) {
      state = const AuthState();
    }
  }

  Future<String?> signUp(
    String userId,
    String nickname,
    String password,
  ) async {
    try {
      await _user.signUp(userId, nickname, password);
      return null;
    } on DioException catch (e) {
      return e.response?.data['message'];
    }
  }

  Future<void> login(String userId, String password) async {
    try {
      final response = await _user.login(userId, password);
      state = state.copyWith(userId: response.id, isAuthenticated: true);
    } on DioException catch (e) {
      state = const AuthState();
      return e.response?.data['message'];
    }
  }

  Future<Response<dynamic>> logout() async {
    return await _user.logout();
  }
}
