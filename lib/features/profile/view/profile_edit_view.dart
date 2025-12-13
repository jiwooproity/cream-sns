import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/features/auth/provider/auth_provider.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

// Widgets
import 'package:cream_sns/core/widgets/custom_appbar.dart';
import 'package:cream_sns/features/profile/widgets/profile_changer.dart';

class ProfileEditView extends ConsumerStatefulWidget {
  const ProfileEditView({super.key});

  @override
  ConsumerState<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends ConsumerState<ProfileEditView> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  final TextEditingController _nickname = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  void dispose() {
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
        actionsPadding: EdgeInsets.symmetric(horizontal: 15),
        actions: [
          GestureDetector(
            onTap: () {
              changeProfile();
            },
            child: Text("완료", style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () async {
                  final image = await _picker.pickImage(
                    source: ImageSource.gallery,
                    maxWidth: 100,
                    maxHeight: 100,
                    imageQuality: 85,
                  );
                  setState(() {
                    _selectedImage = image;
                  });
                },
                child: Column(
                  children: [
                    ProfileChanger(
                      originalImage: user.profile,
                      pickedImage: _selectedImage,
                    ),
                    SizedBox(height: 5),
                    Text("사진 수정", style: TextStyle(color: AppColors.black)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Text("닉네임"),
            TextField(
              controller: _nickname,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
              ),
            ),
            SizedBox(height: 12),
            Text("한 줄 소개"),
            TextField(
              controller: _description,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> changeProfile() async {
    MultipartFile? image;

    if (_selectedImage != null) {
      final file = _selectedImage!.path;
      final filename = _selectedImage!.name;
      image = await MultipartFile.fromFile(file, filename: filename);
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
