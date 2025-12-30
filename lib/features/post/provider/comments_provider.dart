import 'package:cream_sns/store/post_store.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Models
import 'package:cream_sns/features/post/models/comment.dart';

// Service
import 'package:cream_sns/features/post/data/comments_service.dart';
import 'package:flutter_riverpod/legacy.dart';

final commentsProvider = FutureProvider.family<List<Comment>, String>((
  ref,
  postId,
) {
  return ref.read(commentsClientProvider).getComments(postId);
});

final commentsActionProvider =
    StateNotifierProvider<CommentsActionNotifier, CommentsActionState>((ref) {
      return CommentsActionNotifier(ref);
    });

class CommentsActionNotifier extends StateNotifier<CommentsActionState> {
  CommentsActionNotifier(this.ref)
    : super(CommentsActionState(isLoading: false));

  final Ref ref;

  Future<Response?> addComment(String postId, String content) async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await ref
          .read(commentsClientProvider)
          .addComment(postId, content);

      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        ref.invalidate(commentsProvider(postId));
        ref.read(postStoreProvider.notifier).increaseCommentCount(postId);
      }

      return response;
    } on DioException catch (e) {
      state = state.copyWith(isLoading: false);
      return null;
    }
  }

  Future<void> deleteComment(String commentId, String postId) async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await ref
          .read(commentsClientProvider)
          .deleteComment(commentId, postId);

      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        ref.invalidate(commentsProvider(postId));
        ref.read(postStoreProvider.notifier).decreaseCommentCount(postId);
      }
    } on DioException catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}

class CommentsActionState {
  CommentsActionState({this.isLoading = false});

  final bool isLoading;

  CommentsActionState copyWith({bool? isLoading}) {
    return CommentsActionState(isLoading: isLoading ?? this.isLoading);
  }
}
