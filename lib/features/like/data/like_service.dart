import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dio
import 'package:cream_sns/core/network/dio_instance.dart';

// Models
import 'package:cream_sns/features/post/models/post.dart';

final likeClientProvider = Provider((ref) {
  final client = ref.read(dioProvider);
  return LikeClient(client);
});

class LikeClient {
  LikeClient(this._dio);

  final DioInstance _dio;

  Future<List<PostDetail>> getLikes(String userId) async {
    final response = await _dio.get("/like/list/$userId");
    final List<dynamic> likes = response.data;
    return likes.map((like) => PostDetail.fromJson(like)).toList();
  }

  Future<void> doLike(String postId) async {
    await _dio.post(path: "/like/add", data: {'postId': postId});
  }

  Future<void> cancelLike(String postId) async {
    await _dio.delete("/like/remove", data: {'postId': postId});
  }
}