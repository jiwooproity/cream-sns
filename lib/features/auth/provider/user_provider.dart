import "package:dio/dio.dart";
import "package:flutter_riverpod/legacy.dart";

// Models
import "package:cream_sns/features/auth/model/user.dart";

// Data
import "package:cream_sns/features/auth/data/user_service.dart";

final userStateProvider = StateNotifierProvider<UserStateNotifier, UserState>((
  ref,
) {
  final client = ref.watch(userClientProvider);
  return UserStateNotifier(client);
});

class UserState {
  const UserState({this.user, this.isLoading = false});

  final User? user;
  final bool? isLoading;

  UserState copyWith({User? user, bool? isLoading}) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool get isAuthenticated => user != null;
}

class UserStateNotifier extends StateNotifier<UserState> {
  UserStateNotifier(this._user) : super(const UserState());

  final UserClient _user;

  void setLoading() {
    state = state.copyWith(isLoading: true);
  }

  Future<void> edit(FormData formData) async {
    try {
      state = state.copyWith(
        user: await _user.edit(formData),
        isLoading: false,
      );
    } on DioException catch (e) {
      state = state.copyWith();
    }
  }

  Future<void> me() async {
    try {
      state = state.copyWith(user: await _user.me());
    } on DioException catch (e) {
      state = const UserState();
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
      state = state.copyWith(user: await _user.login(userId, password));
    } on DioException catch (e) {
      state = state.copyWith();
      return e.response?.data['message'];
    }
  }

  Future<Response<dynamic>> logout() async {
    return await _user.logout();
  }
}
