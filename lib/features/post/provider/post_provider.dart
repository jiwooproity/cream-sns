import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_riverpod/legacy.dart";

// Models
import "package:cream_sns/features/post/models/post.dart";
import "package:cream_sns/features/home/model/feed.dart";

// Data
import "package:cream_sns/features/post/data/post_service.dart";
import "package:cream_sns/features/home/data/feed_service.dart";

final postDetailProvider = FutureProvider.family<Feed, String>((ref, postId) async {
  final feed = ref.watch(feedClientProvider);
  return await feed.getFeed(postId);
});

final postStateProvider = StateNotifierProvider<PostStateNotifier, PostState>((
  ref,
) {
  final client = ref.watch(postClientProvider);
  return PostStateNotifier(client);
});

class PostState {
  PostState({required this.postList, this.isLoading = false});

  final List<Post> postList;
  final bool? isLoading;

  PostState copyWith({List<Post>? postList, bool? isLoading}) {
    return PostState(
      postList: postList ?? this.postList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class PostStateNotifier extends StateNotifier<PostState> {
  PostStateNotifier(this._post) : super(PostState(postList: []));

  final PostClient _post;

  void setLoading() {
    state = state.copyWith(isLoading: true);
  }

  Future<void> createPost(FormData formData) async {
    try {
      state = state.copyWith(
        postList: await _post.createPost(formData),
        isLoading: false,
      );
    } on DioException catch (e) {
      state = PostState(postList: []);
    }
  }

  Future<void> getPosts() async {
    try {
      state = state.copyWith(postList: await _post.getPosts());
    } on DioException catch (e) {
      state = PostState(postList: []);
    }
  }
}