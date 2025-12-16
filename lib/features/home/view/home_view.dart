import 'package:cream_sns/features/crop/model/crop_param.dart';
import 'package:cream_sns/features/home/data/feed_service.dart';
import 'package:cream_sns/features/home/model/feed.dart';
import 'package:cream_sns/shared/utils/image_size.dart';
import 'package:cream_sns/shared/widgets/buttons/tile_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

// Widgets
import 'package:cream_sns/core/widgets/custom_appbar.dart';
import 'package:cream_sns/shared/widgets/divider/custom_divider.dart';
import 'package:cream_sns/shared/widgets/modal/custom_modal.dart';
import 'package:cream_sns/features/post/models/post.dart';
import 'package:cream_sns/features/post/widgets/post_card.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ImagePicker _picker = ImagePicker();

  List<Feed> feeds = [];

  @override
  void initState() {
    super.initState();
    getFeeds();
  }

  void getFeeds() async {
    final response = await ref.read(feedClientProvider).getFeeds();
    setState(() {
      feeds = response;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 15),
              itemCount: feeds.length,
              itemBuilder: (BuildContext context, int idx) {
                return PostCard(feed: feeds[idx]);
              },
            ),
          ),
        ],
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
