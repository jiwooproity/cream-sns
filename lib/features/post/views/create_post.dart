import 'dart:typed_data';

import 'package:cream_sns/features/auth/provider/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/features/post/provider/post_provider.dart';

// Widgets
import 'package:cream_sns/core/widgets/custom_appbar.dart';
import 'package:cream_sns/shared/widgets/divider/custom_divider.dart';
import 'package:cream_sns/shared/widgets/buttons/action_button.dart';

class CreatePost extends ConsumerStatefulWidget {
  final Uint8List image;

  const CreatePost({super.key, required this.image});

  @override
  ConsumerState<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends ConsumerState<CreatePost> {
  final TextEditingController _content = TextEditingController();

  @override
  void dispose() {
    _content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final action = ref.watch(postActionProvider);

    return Scaffold(
      appBar: CustomAppbar(
        title: "게시글 작성",
        titleSize: 15,
        centerTitle: true,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
        actions: [
          ActionButton(
            onTap: () => createPost(),
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
                      child: Image.memory(widget.image, fit: BoxFit.cover),
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

  Future<void> createPost() async {
    final image = MultipartFile.fromBytes(
      widget.image,
      filename: "profile.png",
    );

    final formData = FormData.fromMap({
      'image': image,
      'content': _content.text,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });

    final userId = ref.read(authStateProvider).userId!;
    await ref.read(postActionProvider.notifier).createPost(userId, formData);
    if (mounted) context.go("/home");
  }
}
