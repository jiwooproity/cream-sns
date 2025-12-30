import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/features/post/provider/comments_provider.dart';
import 'package:cream_sns/features/auth/provider/auth_provider.dart';

// Widgets
import 'package:cream_sns/shared/loading/custom_indicator.dart';
import 'package:cream_sns/shared/widgets/buttons/tile_text_button.dart';
import 'package:cream_sns/shared/widgets/modal/custom_modal.dart';
import 'package:go_router/go_router.dart';

class CommentList extends ConsumerWidget {
  const CommentList({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authStateProvider).userId!;
    final commentsAsync = ref.watch(commentsProvider(postId));

    return commentsAsync.when(
      data: (comments) {
        return comments.isEmpty
            ? const Center(child: Text("작성된 댓글이 없습니다."))
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
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
                        if (userId == comment.author.id)
                          CustomModal(
                            icon: Icons.more_horiz,
                            iconSize: 20,
                            children: [
                              TileTextButton(
                                "댓글 삭제",
                                onTap: () {
                                  context.pop();
                                  deleteComment(ref, comment.id);
                                },
                              ),
                            ],
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

  Future<void> deleteComment(WidgetRef ref, String commentId) async {
    await ref
        .read(commentsActionProvider.notifier)
        .deleteComment(commentId, postId);
  }

  Widget _profileImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(image, width: 40, height: 40, fit: BoxFit.cover),
    );
  }
}
