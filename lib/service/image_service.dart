import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageTool {
  File? _imageFile;
  String? _imageUrl;
  CroppedFile? _croppedImage;

  Future pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      _imageFile = pickedImage != null ? File(pickedImage.path) : null;

      if (_imageFile != null) {
        _imageFile = await cropImage(imageFile: _imageFile);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future pickImageNotCrop() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      _imageFile = pickedImage != null ? File(pickedImage.path) : null;
    } catch (e) {
      rethrow;
    }
  }

  Future<File?> cropImage({required File? imageFile}) async {
    try {
      _croppedImage =
          await ImageCropper().cropImage(sourcePath: imageFile!.path);
      return _croppedImage != null ? File(_croppedImage!.path) : null;
    } catch (e) {
      rethrow;
    }
  }

  Future uploadImage(File imageFile, String reference) async {
    try {
      String fileName = basename(imageFile.path);

      Reference storageReference =
          FirebaseStorage.instance.ref(reference).child(fileName);

      await storageReference.putFile(imageFile);
      _imageUrl = await storageReference.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }

  Future deleteImage(String url) async {
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
    } catch (e) {
      rethrow;
    }
  }

  File? get imagetFile => _imageFile;

  File? get croppedImageFile =>
      _croppedImage != null ? File(_croppedImage!.path) : null;

  String? get imageUrl => _imageUrl;
}
