import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileChanger extends StatelessWidget {
  final String originalImage;
  final XFile? pickedImage;

  const ProfileChanger({super.key, required this.originalImage, this.pickedImage});

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if(pickedImage != null) {
      imageProvider = FileImage(File(pickedImage!.path));
    } else {
      imageProvider = NetworkImage(originalImage);
    }

    return CircleAvatar(
      radius: 50,
      backgroundImage: imageProvider,
    );
  }
}
