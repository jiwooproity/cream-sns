import 'package:cream_sns/features/post/data/comments_service.dart';
import 'package:cream_sns/features/post/provider/comments_provider.dart';
import 'package:cream_sns/shared/loading/custom_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

class CommentInput extends ConsumerStatefulWidget {
  const CommentInput({super.key, required this.postId});

  final String postId;

  @override
  ConsumerState<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends ConsumerState<CommentInput> {
  final TextEditingController _content = TextEditingController();

  @override
  void dispose() {
    _content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commentsState = ref.watch(commentsActionProvider);

    return Container(
      padding: const EdgeInsets.only(left: 15, top: 8, right: 5, bottom: 8),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.grey)),
      ),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: _content,
                decoration: const InputDecoration(
                  hintText: "남기고 싶은 말을 작성하세요.",
                  hintStyle: TextStyle(fontSize: 14),
                  isDense: true,
                  border: InputBorder.none,
                ),
              ),
            ),
            commentsState.isLoading
                ? const SizedBox(child: CustomIndicator())
                : IconButton(
                    onPressed: () => sendComment(),
                    icon: const Icon(Icons.airplanemode_active),
                    padding: EdgeInsets.zero,
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> sendComment() async {
    final content = _content.text;

    if (content.isNotEmpty) {
      final response = await ref
          .read(commentsActionProvider.notifier)
          .addComment(widget.postId, content);

      if (response?.statusCode == 200) {
        _content.clear();
      }
    }
  }
}
