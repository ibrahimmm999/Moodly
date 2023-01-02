import 'package:bloc/bloc.dart';

class ImageUrlCubit extends Cubit<String> {
  ImageUrlCubit() : super('');

  void changeImageUrl(String imageUrl) {
    emit(imageUrl);
  }
}
