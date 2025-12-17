import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/features/post/provider/post_provider.dart';

class PostTab extends ConsumerWidget {
  const PostTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postState = ref.watch(postStateProvider);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: postState.postList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            final id = postState.postList[index].id;
            context.push("/post/detail", extra: id);
          },
          child: Image.network(postState.postList[index].image.url, fit: BoxFit.cover),
        );
      },
    );
  }
}
