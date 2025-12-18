import 'package:cream_sns/features/home/data/feed_service.dart';
import 'package:cream_sns/features/home/model/feed.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final feedListProvider = FutureProvider.family<List<Feed>, String>((ref, id) async {
  final response = ref.watch(feedClientProvider);
  return response.getFeeds(id);
});