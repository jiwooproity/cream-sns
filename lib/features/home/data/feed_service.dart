import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dio
import 'package:cream_sns/core/network/dio_instance.dart';

// Models
import 'package:cream_sns/features/home/model/feed.dart';

final feedClientProvider = Provider((ref) {
  final apiClient = ref.watch(dioProvider);
  return FeedClient(apiClient);
});

class FeedClient {
  FeedClient(this._dio);

  final DioInstance _dio;

  Future<List<Feed>> getFeeds() async {
    final response = await _dio.get("/feed/list");
    final List<dynamic> feeds = response.data;
    return feeds.map((feed) => Feed.fromJson(feed)).toList();
  }

  Future<Feed> getFeed(String postId) async {
    final response = await _dio.get("/feed/detail/$postId");
    final dynamic feed = response.data;
    return Feed.fromJson(feed);
  }
}