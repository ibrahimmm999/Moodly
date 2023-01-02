import 'package:bloc/bloc.dart';

class ImageUrlCubit extends Cubit<String> {
  ImageUrlCubit() : super('');

  void changeImageFile(String imageUrl) {
    emit(imageUrl);
  }
}
