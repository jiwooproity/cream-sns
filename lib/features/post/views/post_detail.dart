import 'package:cream_sns/store/post_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/features/post/provider/post_provider.dart';

// Widgets
import 'package:cream_sns/core/widgets/custom_appbar.dart';
import 'package:cream_sns/features/post/widgets/post_card.dart';
import 'package:cream_sns/shared/loading/custom_indicator.dart';

class PostDetail extends ConsumerWidget {
  const PostDetail({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(postStoreProvider)[postId];

    if(post == null) {
      return const CustomIndicator();
    }

    return Scaffold(
      appBar: const CustomAppbar(title: "게시글", titleSize: 15),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: PostCard(post: post),
      ),
    );
  }
}
