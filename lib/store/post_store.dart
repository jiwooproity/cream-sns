import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Models
import 'package:cream_sns/features/post/models/post.dart';

final postStoreProvider =
    StateNotifierProvider<PostStore, Map<String, PostDetail>>(
      (ref) => PostStore(ref),
    );

class PostStore extends StateNotifier<Map<String, PostDetail>> {
  PostStore(this.ref) : super({});

  final Ref ref;

  void upsert(PostDetail post) {
    state = {...state, post.id: post};
  }

  void upsertAll(List<PostDetail> posts) {
    final next = {...state};

    for (final post in posts) {
      next[post.id] = post;
    }

    state = next;
  }

  void remove(String postId) {
    final next = {...state};
    next.remove(postId);
    state = next;
  }
}
