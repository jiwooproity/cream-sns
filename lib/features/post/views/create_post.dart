import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Widgets
import 'package:cream_sns/core/widgets/custom_appbar.dart';

class CreatePost extends StatelessWidget {
  final XFile image;

  const CreatePost({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppbar(
        title: "포스트 작성",
        titleSize: 15,
        centerTitle: true,
        actionsPadding: EdgeInsets.symmetric(horizontal: 20),
        actions: [Text("완료", style: TextStyle(fontSize: 15))],
      ),
    );
  }
}
