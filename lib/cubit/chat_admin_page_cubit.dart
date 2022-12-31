import 'package:bloc/bloc.dart';

class ChatAdminPageCubit extends Cubit<int> {
  ChatAdminPageCubit() : super(0);

  void changeChatAdminPage(int index) {
    emit(index);
  }
}
