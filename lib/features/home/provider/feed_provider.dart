import 'package:cream_sns/store/index_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Store
import 'package:cream_sns/store/post_store.dart';

// Service
import 'package:cream_sns/features/home/data/feed_service.dart';

// Models
import 'package:flutter_riverpod/legacy.dart';

final feedProvider = StateNotifierProvider<FeedNotifier, IndexState>(
  (ref) => FeedNotifier(ref),
);

class FeedNotifier extends StateNotifier<IndexState> {
  FeedNotifier(this.ref) : super(const IndexState()) {
    getFeeds();
  }

  final Ref ref;

  Future<void> getFeeds() async {
    state = state.copyWith(isLoading: true);

    try {
      final posts = await ref.read(feedClientProvider).getFeeds();
      ref.read(postStoreProvider.notifier).upsertAll(posts);
      state = state.copyWith(
        ids: posts.map((post) => post.id).toList(),
        isLoading: false,
      );
    } on DioException catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void clear() {
    state = const IndexState();
  }
}
