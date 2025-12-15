import "package:dio/dio.dart";
import "package:flutter_riverpod/legacy.dart";

// Models
import "package:cream_sns/features/post/models/post.dart";

// Service
import "package:cream_sns/features/post/services/post_service.dart";

final postStateProvider = StateNotifierProvider<PostStateNotifier, PostState>((
  ref,
) {
  final repository = ref.watch(postRepositoryProvider);
  return PostStateNotifier(repository);
});

class PostState {
  final List<Post> postList;

  PostState({required this.postList});

  PostState copyWith({List<Post>? postList}) {
    return PostState(postList: postList ?? this.postList);
  }
}

class PostStateNotifier extends StateNotifier<PostState> {
  final PostRepository _repository;

  PostStateNotifier(this._repository) : super(PostState(postList: []));

  Future<void> createPost(FormData formData) async {
    try {
      final response = await _repository.createPost(formData);
      state = state.copyWith(postList: response);
    } on DioException catch (e) {
      state = PostState(postList: []);
    }
  }

  Future<void> getPosts() async {
    try {
      final response = await _repository.getPosts();
      state = state.copyWith(postList: response);
    } on DioException catch (e) {
      print(e);
      state = PostState(postList: []);
    }
  }
}
