import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

// Models
import 'package:cream_sns/shared/widgets/modal/custom_modal.dart';

// Provider
import 'package:cream_sns/features/auth/provider/auth_provider.dart';
import 'package:cream_sns/features/home/provider/feed_provider.dart';

// Widgets
import 'package:cream_sns/core/widgets/custom_appbar.dart';
import 'package:cream_sns/shared/widgets/divider/custom_divider.dart';
import 'package:cream_sns/features/post/widgets/post_card.dart';
import 'package:cream_sns/features/crop/model/crop_param.dart';
import 'package:cream_sns/shared/utils/image_size.dart';
import 'package:cream_sns/shared/widgets/buttons/tile_text_button.dart';
import 'package:cream_sns/shared/loading/custom_indicator.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final myId = ref.read(authStateProvider).userId!;
    final feedsAsync = ref.watch(feedListProvider(myId));

    return Scaffold(
      appBar: CustomAppbar(
        title: "Cream",
        actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
        actions: [
          CustomModal(
            icon: Icons.post_add_outlined,
            children: [
              TileTextButton(
                "카메라",
                onTap: () => doPost(context, ImageSource.camera),
              ),
              const CustomDivider(),
              TileTextButton(
                "갤러리",
                onTap: () => doPost(context, ImageSource.gallery),
              ),
            ],
          ),
        ],
      ),
      body: feedsAsync.when(
        data: (feeds) {
          if (feeds.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 15),
                    itemCount: feeds.length,
                    itemBuilder: (BuildContext context, int idx) {
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          context.push("/post/detail", extra: feeds[idx].id);
                        },
                        child: PostCard(feed: feeds[idx]),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("불러올 피드 목록이 없습니다."));
          }
        },
        error: (err, stack) =>
            const Center(child: Text("피드 목록을 불러오는데 실패하였습니다.")),
        loading: () => const CustomIndicator(),
      ),
    );
  }

  Future<void> doPost(BuildContext context, ImageSource imageSource) async {
    context.pop();

    final image = await _picker.pickImage(
      source: imageSource,
      imageQuality: 85,
    );

    if (image != null) {
      final imageSize = await getFileImageSize(image);
      final aspectRatio = getAspectRatio(imageSize);

      if (context.mounted) {
        context.push(
          "/image/crop",
          extra: CropParam(
            image: image,
            aspectRatio: aspectRatio,
            goBack: false,
            path: "/post/create",
          ),
        );
      }
    }
  }
}
