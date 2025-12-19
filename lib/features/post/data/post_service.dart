import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dio
import 'package:cream_sns/core/network/dio_instance.dart';

// Models
import 'package:cream_sns/features/post/models/post.dart';

final postClientProvider = Provider((ref) {
  final apiClient = ref.watch(dioProvider);
  return PostClient(apiClient);
});

class PostClient {
  PostClient(this._dio);

  final DioInstance _dio;

  Future<Response> deletePost(String postId) async {
    return await _dio.delete("/post/delete/$postId");
  }

  Future<Response> createPost(FormData formData) async {
    return await _dio.post(
      path: "/post/create",
      data: formData,
    );
  }

  Future<List<Post>> getPosts(String userId) async {
    final response = await _dio.get("/post/list/$userId");
    final List<dynamic> posts = response.data;
    return posts.map((post) => Post.fromJson(post)).toList();
  }

  Future<PostDetail> getPost(String postId) async {
    final response = await _dio.get("/post/detail/$postId");
    final dynamic feed = response.data;
    return PostDetail.fromJson(feed);
  }
}