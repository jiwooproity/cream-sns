import 'package:flutter_riverpod/flutter_riverpod.dart';

// Service
import 'package:cream_sns/features/home/data/feed_service.dart';

// Models
import 'package:cream_sns/features/post/models/post.dart';

final feedListProvider = FutureProvider.family<List<PostDetail>, String>((ref, id) async {
  final response = ref.watch(feedClientProvider);
  return response.getFeeds(id);
});