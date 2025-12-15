import 'package:image_picker/image_picker.dart';

class CropParam {
  final XFile image;
  final double aspectRatio;
  final bool goBack;
  final String path;

  CropParam({required this.image, required this.aspectRatio, this.goBack = true, this.path = ""});
}