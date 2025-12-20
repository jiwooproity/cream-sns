import 'package:flutter_riverpod/flutter_riverpod.dart';

// Models
import 'package:cream_sns/features/auth/model/user.dart';

import 'package:cream_sns/core/network/dio_instance.dart';

final searchClientProvider = Provider((ref) {
  final dioInstance = ref.watch(dioProvider);
  return SearchClient(dioInstance);
});

class SearchClient {
  SearchClient(this._dio);

  final DioInstance _dio;

  Future<List<User>> getSearchResult({
    required String searchText,
  }) async {
    final query = "/search?q=$searchText";
    final response = await _dio.get(query);
    final List<dynamic> users = response.data;
    return users.map((user) => User.fromJson(user)).toList();
  }
}
