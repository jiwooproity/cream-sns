import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Model
import 'package:cream_sns/features/crop/model/crop_param.dart';
import 'package:cream_sns/features/profile/model/profile.dart';

// Provider
import 'package:cream_sns/features/auth/provider/auth_provider.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

// Widgets
import 'package:cream_sns/core/widgets/custom_appbar.dart';
import 'package:cream_sns/shared/widgets/modal/custom_modal.dart';
import 'package:cream_sns/shared/widgets/buttons/action_button.dart';
import 'package:cream_sns/shared/widgets/buttons/tile_text_button.dart';
import 'package:cream_sns/shared/widgets/divider/custom_divider.dart';
import 'package:cream_sns/features/profile/widgets/profile_changer.dart';
import 'package:cream_sns/features/profile/widgets/profile_text_field.dart';
import 'package:cream_sns/features/profile/provider/profile_provider.dart';

class ProfileEditView extends ConsumerStatefulWidget {
  const ProfileEditView({super.key, required this.user});

  final Profile user;

  @override
  ConsumerState<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends ConsumerState<ProfileEditView> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _selectedImage;

  final TextEditingController _nickname = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  void dispose() {
    _selectedImage = null;
    _nickname.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nickname.text = widget.user.nickname;
    _description.text = widget.user.description;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authStateProvider);

    return Scaffold(
      appBar: CustomAppbar(
        title: "프로필 편집",
        titleSize: 15,
        centerTitle: true,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
        actions: [
          ActionButton(
            onTap: () => changeProfile(),
            loading: state.isLoading!,
            text: "완료",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CustomModal(
                isAction: false,
                children: [
                  TileTextButton(
                    "사진 찍기",
                    onTap: () => selectImage(ImageSource.camera),
                  ),
                  const CustomDivider(),
                  TileTextButton(
                    "갤러리에서 가져오기",
                    onTap: () => selectImage(ImageSource.gallery),
                  ),
                ],
                child: editProfile(widget.user.profile.url),
              ),
            ),
            // 닉네임 영역
            const SizedBox(height: 30),
            const Text("닉네임"),
            ProfileEditTextField(controller: _nickname),
            // 한 줄 소개 영역
            const SizedBox(height: 20),
            const Text("한 줄 소개"),
            ProfileEditTextField(controller: _description),
          ],
        ),
      ),
    );
  }

  Widget editProfile(String url) {
    return Column(
      children: [
        ProfileChanger(originalImage: url, pickedImage: _selectedImage),
        const SizedBox(height: 5),
        const Text("사진 수정", style: TextStyle(color: AppColors.black)),
      ],
    );
  }

  Future<void> selectImage(ImageSource imageSource) async {
    context.pop(); // 하단 모달 닫기

    final image = await _picker.pickImage(
      source: imageSource,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );

    if (image != null && mounted) {
      final cropped = await context.push<Uint8List>(
        "/image/crop",
        extra: CropParam(image: image, aspectRatio: 1),
      );

      setState(() {
        _selectedImage = cropped;
      });
    }
  }

  Future<void> changeProfile() async {
    MultipartFile? image;

    ref.read(authStateProvider.notifier).setLoading();

    if (_selectedImage != null) {
      image = MultipartFile.fromBytes(_selectedImage!, filename: "profile.png");
    }

    final formData = FormData.fromMap({
      'image': image,
      'nickname': _nickname.text,
      'description': _description.text,
    });

    await ref.read(authStateProvider.notifier).edit(formData);
    ref.invalidate(profileProvider(widget.user.id));
    if (mounted) context.go("/profile");
  }
}
