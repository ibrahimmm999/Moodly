import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageTool {
  File? _imageFile;
  String? _imageUrl;

  Future pickImage() async {
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

  Future uploadImage(File imageFile, String reference) async {
    String fileName = basename(imageFile.path);

    Reference storageReference =
        FirebaseStorage.instance.ref(reference).child(fileName);

    await storageReference.putFile(imageFile);
    _imageUrl = await storageReference.getDownloadURL();
  }

  Future deleteImage(String url) async {
    await FirebaseStorage.instance.refFromURL(url).delete();
  }

  File? get imagetFile => _imageFile;

  String? get imageUrl => _imageUrl;
}
