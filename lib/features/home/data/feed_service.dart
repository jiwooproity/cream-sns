import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dio
import 'package:cream_sns/core/network/dio_instance.dart';

// Models
import 'package:cream_sns/features/post/models/post.dart';

final feedClientProvider = Provider((ref) {
  final apiClient = ref.watch(dioProvider);
  return FeedClient(apiClient);
});

class FeedClient {
  FeedClient(this._dio);

  final DioInstance _dio;

  Future<List<PostDetail>> getFeeds() async {
    final response = await _dio.get("/feed/list");
    final List<dynamic> feeds = response.data;
    return feeds.map((feed) => PostDetail.fromJson(feed)).toList();
  }
}