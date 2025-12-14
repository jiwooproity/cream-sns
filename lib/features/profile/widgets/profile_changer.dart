import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ProfileChanger extends StatelessWidget {
  final String originalImage;
  final Uint8List? pickedImage;

  const ProfileChanger({super.key, required this.originalImage, this.pickedImage});

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if(pickedImage != null) {
      imageProvider = MemoryImage(pickedImage!);
    } else {
      imageProvider = NetworkImage(originalImage);
    }

    return CircleAvatar(
      radius: 50,
      backgroundImage: imageProvider,
    );
  }
}
