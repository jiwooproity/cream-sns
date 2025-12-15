import 'dart:ui';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ImageSize {
  final double width;
  final double height;

  ImageSize({required this.width, required this.height});

  factory ImageSize.fromJson(Map<String, dynamic> json) {
    return ImageSize(width: json['width'], height: json['height']);
  }
}

Future<ImageSize> getImageSize(XFile file) async {
  final Uint8List data = await file.readAsBytes();
  final codec = await instantiateImageCodec(data);
  final frame = await codec.getNextFrame();
  final image = frame.image;

  return ImageSize(
    width: image.width.toDouble(),
    height: image.height.toDouble(),
  );
}

double getAspectRatio(ImageSize imageSize) {
  if(imageSize.width > imageSize.height) {
    return 4 / 3;
  } else {
    return 4 / 5;
  }
}