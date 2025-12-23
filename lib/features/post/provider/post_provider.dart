import "package:cream_sns/features/like/provider/likes_provider.dart";
import "package:cream_sns/features/post/models/post.dart";
import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_riverpod/legacy.dart";

// Store
import "package:cream_sns/store/index_state.dart";
import "package:cream_sns/store/post_store.dart";

// Data
import "package:cream_sns/features/post/data/post_service.dart";
import "package:cream_sns/features/like/data/like_service.dart";

// Provider
import "package:cream_sns/features/profile/provider/profile_provider.dart";


final postProvider =
    StateNotifierProvider.family<PostNotifier, IndexState, String>(
      (ref, userId) => PostNotifier(ref, userId),
    );

class PostNotifier extends StateNotifier<IndexState> {
  PostNotifier(this.ref, this.userId) : super(const IndexState()) {
    getPosts(userId);
  }

  final Ref ref;
  final String userId;

  Future<void> getPosts(String userId) async {
    state = state.copyWith(isLoading: true);

    try {
      final posts = await ref.read(postClientProvider).getPosts(userId);
      ref.read(postStoreProvider.notifier).upsertAll(posts);
      state = state.copyWith(
        ids: posts.map((post) => post.id).toList(),
        isLoading: false,
      );
    } on DioException catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void add(String postId) {
    state = state.copyWith(ids: [postId, ...state.ids]);
  }

  void remove(String postId) {
    state = state.copyWith(ids: state.ids.where((id) => id != postId).toList());
  }

  void clear() {
    state = const IndexState();
  }
}

enum PostActionState { idle, loading, success, error }

final postActionProvider =
    StateNotifierProvider<PostActionNotifier, PostActionState>(
      (ref) => PostActionNotifier(ref),
    );

class PostActionNotifier extends StateNotifier<PostActionState> {
  PostActionNotifier(this.ref) : super(PostActionState.idle);

  final Ref ref;

  Future<void> doLike(String postId) async {
    state = PostActionState.loading;

    try {
      await ref.read(likeClientProvider).doLike(postId);
      ref.read(postStoreProvider.notifier).toggleLike(postId);
      ref.invalidate(likesProvider);
      state = PostActionState.success;
    } on DioException catch (e) {
      state = PostActionState.error;
    }
  }

  Future<void> cancelLike(String postId) async {
    state = PostActionState.loading;

    try {
      await ref.read(likeClientProvider).cancelLike(postId);
      ref.read(postStoreProvider.notifier).toggleLike(postId);
      ref.invalidate(likesProvider);
      state = PostActionState.success;
    } on DioException catch (e) {
      state = PostActionState.error;
    }
  }

  Future<String?> createPost(String userId, FormData formData) async {
    state = PostActionState.loading;

    try {
      final post = await ref.read(postClientProvider).createPost(formData);
      ref.read(postStoreProvider.notifier).upsert(post);
      ref.read(postProvider(userId).notifier).add(post.id);
      ref.invalidate(profileProvider(userId));
      state = PostActionState.success;
      return post.id;
    } on DioException catch (e) {
      state = PostActionState.error;
      return null;
    }
  }

  Future<void> editPost(String postId, String content) async {
    state = PostActionState.loading;

    try {
      final edited = await ref
          .read(postClientProvider)
          .editPosts(postId, content);
      ref.read(postStoreProvider.notifier).upsert(edited);
      state = PostActionState.success;
    } on DioException catch (e) {
      state = PostActionState.error;
    }
  }

  Future<void> deletePost(String userId, String postId) async {
    state = PostActionState.loading;

    try {
      await ref.read(postClientProvider).deletePost(postId);
      ref.read(postStoreProvider.notifier).remove(postId);
      ref.read(postProvider(userId).notifier).remove(postId);
      ref.invalidate(profileProvider(userId));
      state = PostActionState.success;
    } on DioException catch (e) {
      state = PostActionState.error;
    }
  }
}
