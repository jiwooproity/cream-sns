import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crop_image/crop_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Model
import 'package:cream_sns/features/crop/model/crop_param.dart';

// Provider
import 'package:cream_sns/features/auth/provider/auth_provider.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

// Widgets
import 'package:cream_sns/core/widgets/custom_appbar.dart';
import 'package:cream_sns/shared/widgets/modal/custom_modal.dart';
import 'package:cream_sns/shared/widgets/divider/custom_divider.dart';
import 'package:cream_sns/features/profile/widgets/profile_changer.dart';

class ProfileEditView extends ConsumerStatefulWidget {
  const ProfileEditView({super.key});

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
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).user!;
    _nickname.text = user.nickname;
    _description.text = user.description;

    return Scaffold(
      appBar: CustomAppbar(
        title: "프로필 편집",
        titleSize: 15,
        centerTitle: true,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
        actions: [
          GestureDetector(
            onTap: () {
              changeProfile();
            },
            child: const Text("완료", style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => CustomModal(
                      isAction: false,
                      widgets: [
                        ListTile(
                          onTap: () {
                            selectImage(ImageSource.camera);
                          },
                          title: const Center(child: Text("사진 찍기")),
                        ),
                        const CustomDivider(),
                        ListTile(
                          onTap: () {
                            selectImage(ImageSource.gallery);
                          },
                          title: const Center(child: Text("갤러리에서 가져오기")),
                        ),
                      ],
                    ),
                  );
                },
                child: Column(
                  children: [
                    ProfileChanger(
                      originalImage: user.profile,
                      pickedImage: _selectedImage,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "사진 수정",
                      style: TextStyle(color: AppColors.black),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text("닉네임"),
            TextField(
              controller: _nickname,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 5),
              ),
            ),
            const SizedBox(height: 12),
            const Text("한 줄 소개"),
            TextField(
              controller: _description,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectImage(ImageSource imageSource) async {
    final image = await _picker.pickImage(
      source: imageSource,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );

    if (image != null && mounted) {
      context.pop();

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

    if (_selectedImage != null) {
      image = MultipartFile.fromBytes(_selectedImage!, filename: "profile.png");
    }

    final formData = FormData.fromMap({
      'image': image,
      'nickname': _nickname.text,
      'description': _description.text,
    });

    await ref.read(authStateProvider.notifier).editProfile(formData);
    if (context.mounted) ref.context.go("/profile");
  }
}
