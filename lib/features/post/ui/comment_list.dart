import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/features/post/provider/comments_provider.dart';

// Widgets
import 'package:cream_sns/shared/loading/custom_indicator.dart';

class CommentList extends ConsumerWidget {
  const CommentList({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentsAsync = ref.watch(commentsProvider(postId));

    return commentsAsync.when(
      data: (comments) {
        return comments.isEmpty
            ? const Text("댓글이 없습니다.")
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: comments.length,
                itemBuilder: (BuildContext context, int idx) {
                  final comment = comments[idx];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _profileImage(comment.author.profile.url),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment.author.nickname,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(comment.content),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
      },
      error: (err, stack) => const Text("댓글 조회를 실패하였습니다."),
      loading: () => const CustomIndicator(),
    );
  }

  Widget _profileImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(image, width: 40, height: 40, fit: BoxFit.cover),
    );
  }
}
