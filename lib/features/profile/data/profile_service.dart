import 'package:flutter_riverpod/flutter_riverpod.dart';

// Models
import 'package:cream_sns/features/profile/model/profile.dart';

// Dio
import 'package:cream_sns/core/network/dio_instance.dart';

final profileClientProvider = Provider((ref) {
  final dioInstance = ref.watch(dioProvider);
  return ProfileClient(dioInstance);
});

class ProfileClient {
  ProfileClient(this._dio);

  final DioInstance _dio;

  Future<Profile> info(String id) async {
    final response = await _dio.get("/profile/info/$id");
    return Profile.fromJson(response.data);
  }
}