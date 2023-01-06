import 'package:bloc/bloc.dart';

class UnreadSupportCubit extends Cubit<int> {
  UnreadSupportCubit() : super(0);

  void change(int unread) {
    emit(unread);
  }
}
