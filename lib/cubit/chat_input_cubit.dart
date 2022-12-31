import 'package:bloc/bloc.dart';

class ChatInputCubit extends Cubit<String> {
  ChatInputCubit() : super('');

  void chageText(String text) {
    emit(text);
  }
}
