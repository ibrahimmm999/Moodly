import 'package:bloc/bloc.dart';

class StatusHelpCubit extends Cubit<bool> {
  StatusHelpCubit() : super(false);

  void changeStatus(bool status) {
    emit(status);
  }
}
