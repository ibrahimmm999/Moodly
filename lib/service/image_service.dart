import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageTool {
  File? _imageFile;
  String? _a;

  Future pickImage() async {
    _a = 'akuu';
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _imageFile = pickedImage != null ? File(pickedImage.path) : null;

    if (_imageFile != null) {
      _imageFile = await _cropImage(imageFile: _imageFile);
    }
  }

  Future<File?> _cropImage({required File? imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile!.path);
    return croppedImage != null ? File(croppedImage.path) : null;
  }

  File? get imagetFile => _imageFile;

  String? get a => _a;
}
