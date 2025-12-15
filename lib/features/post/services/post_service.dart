import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cream_sns/core/network/dio_instance.dart';

// Models
import 'package:cream_sns/features/post/models/post.dart';

final postRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(dioProvider);
  return PostRepository(apiClient);
});

class PostRepository {
  PostRepository(this._dio);

  final DioInstance _dio;

  Future<List<Post>> createPost(FormData formData) async {
    final response = await _dio.post(
      path: "/post/create",
      data: formData,
    );

    final List<dynamic> posts = response.data;
    return posts.map((post) => Post.fromJson(post)).toList();
  }

  Future<List<Post>> getPosts() async {
    final response = await _dio.get("/post/list");
    final List<dynamic> posts = response.data;
    return posts.map((post) => Post.fromJson(post)).toList();
  }
}
