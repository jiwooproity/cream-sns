import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Models
import 'package:cream_sns/features/post/models/post.dart';

// Provider
import 'package:cream_sns/features/post/provider/post_provider.dart';

// Widgets
import 'package:cream_sns/core/widgets/custom_appbar.dart';
import 'package:cream_sns/shared/widgets/buttons/action_button.dart';
import 'package:cream_sns/shared/widgets/divider/custom_divider.dart';

class EditPost extends ConsumerStatefulWidget {
  const EditPost({super.key, required this.post});

  final Post post;

  @override
  ConsumerState<EditPost> createState() => _EditPostState();
}

class _EditPostState extends ConsumerState<EditPost> {
  final TextEditingController _content = TextEditingController();

  @override
  void dispose() {
    _content.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _content.text = widget.post.content;
  }

  @override
  Widget build(BuildContext context) {
    final action = ref.watch(postActionProvider);

    return Scaffold(
      appBar: CustomAppbar(
        title: "게시글 편집",
        titleSize: 15,
        centerTitle: true,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
        actions: [
          ActionButton(
            onTap: () => editPost(),
            text: "완료",
            loading: action == PostActionState.loading,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              spacing: 15,
              children: [
                Expanded(
                  child: TextField(
                    controller: _content,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: "내용을 입력하세요.",
                      hintStyle: TextStyle(fontSize: 15),
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 10,
                        offset: Offset(4, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        widget.post.image.url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const CustomDivider(height: 1),
          ],
        ),
      ),
    );
  }

  Future<void> editPost() async {
    final content = _content.text;

    if (content == "") return;

    if (widget.post.content != content) {
      await ref
          .read(postActionProvider.notifier)
          .editPost(widget.post.id, content);
    }

    if (mounted) context.pop();
  }
}
