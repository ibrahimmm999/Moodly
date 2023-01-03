import 'package:bloc/bloc.dart';

class ChangeLocationCubit extends Cubit<String> {
  ChangeLocationCubit() : super('');

  void change(String location) {
    emit(location);
  }
}
