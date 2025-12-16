import 'dart:ui';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImageSize {
  final double width;
  final double height;

  ImageSize({required this.width, required this.height});

  factory ImageSize.fromJson(Map<String, dynamic> json) {
    return ImageSize(width: json['width'], height: json['height']);
  }
}

Future<ImageSize> getFileImageSize(XFile file) async {
  final Uint8List data = await file.readAsBytes();
  final codec = await instantiateImageCodec(data);
  final frame = await codec.getNextFrame();
  final image = frame.image;

  return ImageSize(
    width: image.width.toDouble(),
    height: image.height.toDouble(),
  );
}

Future<ImageSize> getNetworkImageSize(String url) async {
  final completer = Completer<ImageSize>();

  final provider = NetworkImage(url);
  final ImageStream stream = provider.resolve(const ImageConfiguration());

  late final ImageStreamListener listener;

  listener = ImageStreamListener((ImageInfo info, bool _) {
    final image = info.image;

    completer.complete(
      ImageSize(width: image.width.toDouble(), height: image.height.toDouble()),
    );

    stream.removeListener(listener);
  });

  stream.addListener(listener);
  return completer.future;
}

double getAspectRatio(ImageSize imageSize) {
  if (imageSize.width > imageSize.height) {
    return 4 / 3;
  } else {
    return 4 / 5;
  }
}
