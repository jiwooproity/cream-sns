import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dio instance
import 'package:cream_sns/core/network/dio_instance.dart';

// Models
import 'package:cream_sns/features/post/models/comment.dart';

final commentsClientProvider = Provider<CommentsClient>((ref) {
  final client = ref.watch(dioProvider);
  return CommentsClient(client);
});

class CommentsClient {
  CommentsClient(this._dio);

  final DioInstance _dio;

  Future<List<Comment>> getComments(String postId) async {
    final response = await _dio.get("/comment/$postId");
    final List<dynamic> comments = response.data;
    return comments.map((comment) => Comment.fromJson(comment)).toList();
  }

  Future<Response> addComment(String postId, String content) async {
    return await _dio.post(path: "/comment/$postId", data: {'content': content});
  }
}
