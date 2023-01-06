import 'package:bloc/bloc.dart';

class UnreadHelpCubit extends Cubit<int> {
  UnreadHelpCubit() : super(0);

  void change(int unread) {
    emit(unread);
  }
}
