import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crop_image/crop_image.dart';

// Widgets
import 'package:cream_sns/core/widgets/custom_appbar.dart';

class CropView extends StatefulWidget {
  final XFile image;
  final double aspectRatio;

  const CropView({super.key, required this.image, required this.aspectRatio});

  @override
  State<CropView> createState() => _CropViewState();
}

class _CropViewState extends State<CropView> {
  late final CropController _cropController;

  @override
  void dispose() {
    _cropController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _cropController = CropController(
      defaultCrop: const Rect.fromLTWH(0, 0, 1, 1),
      aspectRatio: widget.aspectRatio,
      minimumImageSize: 1,
    );
  }

  void cropping() async {
    final cropped = await _cropController.croppedBitmap();
    final imageData = await cropped.toByteData(format: ImageByteFormat.png);
    final bytes = imageData!.buffer.asUint8List();
    if (mounted) context.pop(bytes);
  }

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppbar(
        title: "이미지 조절",
        titleSize: 15,
        centerTitle: true,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
        actions: [
          GestureDetector(onTap: () => cropping(), child: const Text("완료")),
        ],
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: CropImage(
                controller: _cropController,
                image: Image.file(File(widget.image.path), fit: BoxFit.cover),
                minimumImageSize: 1.0,
                maximumImageSize: 3.5,
              ),
            ),
            IgnorePointer(
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
