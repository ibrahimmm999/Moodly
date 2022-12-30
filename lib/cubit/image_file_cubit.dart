import 'dart:io';
import 'package:bloc/bloc.dart';

class ImageFileCubit extends Cubit<File?> {
  ImageFileCubit() : super(null);

  void changeImageFile(File? imageFile) {
    emit(imageFile);
  }
}
