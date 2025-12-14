import 'package:image_picker/image_picker.dart';

class CropParam {
  final XFile image;
  final double aspectRatio;

  CropParam({required this.image, required this.aspectRatio});
}