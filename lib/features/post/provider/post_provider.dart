import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_riverpod/legacy.dart";

// Models
import "package:cream_sns/features/home/model/feed.dart";
import "package:cream_sns/features/post/models/post.dart";

// Data
import "package:cream_sns/features/post/data/post_service.dart";
import "package:cream_sns/features/home/data/feed_service.dart";

final postDetailProvider = FutureProvider.family<Feed, String>((
  ref,
  postId,
) async {
  final feed = ref.watch(feedClientProvider);
  return await feed.getFeed(postId);
});

final myPostProvider = FutureProvider.family<List<Post>, String>((ref, id) async {
  final posts = ref.watch(postClientProvider);
  return posts.getPosts(id);
});

final postStateProvider = StateNotifierProvider<PostStateNotifier, PostState>((
  ref,
) {
  final client = ref.watch(postClientProvider);
  return PostStateNotifier(client);
});

class PostState {
  PostState({ this.isLoading = false});

  final bool isLoading;

  PostState copyWith({bool? isLoading}) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class PostStateNotifier extends StateNotifier<PostState> {
  PostStateNotifier(this._post) : super(PostState());

  final PostClient _post;

  void setLoading() {
    state = state.copyWith(isLoading: true);
  }

  Future<void> createPost(FormData formData) async {
    try {
      await _post.createPost(formData);
      state = state.copyWith(isLoading: false);
    } on DioException catch (e) {
      state = PostState();
    }
  }
}
