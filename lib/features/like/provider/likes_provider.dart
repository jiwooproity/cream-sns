import 'package:cream_sns/features/like/data/like_service.dart';
import 'package:cream_sns/store/post_store.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Store
import 'package:cream_sns/store/index_state.dart';

final likesProvider =
    StateNotifierProvider.family<LikesNotifier, IndexState, String>((
      ref,
      userId,
    ) {
      return LikesNotifier(ref, userId);
    });

class LikesNotifier extends StateNotifier<IndexState> {
  LikesNotifier(this.ref, this.userId) : super(const IndexState()) {
    getLikes(userId);
  }

  final Ref ref;
  final String userId;

  Future<void> getLikes(String userId) async {
    state = state.copyWith(isLoading: true);

    try {
      final likes = await ref.read(likeClientProvider).getLikes(userId);
      ref.read(postStoreProvider.notifier).upsertAll(likes);
      state = state.copyWith(
        ids: likes.map((like) => like.id).toList(),
        isLoading: false
      );
    } on DioException catch(e) {
      state= state.copyWith(isLoading: false);
    }
  }

  void remove(String postId) async {
    final ids = {...state.ids};
    ids.remove(postId);
    state = state.copyWith(ids: ids.toList());
  }
}
