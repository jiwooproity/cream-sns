import 'package:cream_sns/features/auth/provider/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/features/post/provider/main_provider.dart';
import 'package:cream_sns/features/profile/provider/profile_provider.dart';

final postActionProvider = Provider<PostAction>((ref) {
  return PostAction(ref);
});

class PostAction {
  PostAction(this.ref);

  final Ref ref;

  Future<void> createPost({required FormData formData}) async {
    ref.read(postStateProvider.notifier).setLoading();

    await ref.read(postStateProvider.notifier).createPost(formData);

    final myId = ref.read(authStateProvider).userId!;
    ref.invalidate(myPostProvider(myId));
    ref.invalidate(profileProvider(myId));
  }

  Future<void> deletePost({ required String postId, required String authorId }) async {
    ref.read(postStateProvider.notifier).setLoading();

    await ref.read(postStateProvider.notifier).deletePost(postId);

    ref.invalidate(myPostProvider(authorId));
    ref.invalidate(profileProvider(authorId));
  }
}