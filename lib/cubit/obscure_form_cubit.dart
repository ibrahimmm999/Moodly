import 'package:bloc/bloc.dart';

class ObscureFormCubit extends Cubit<bool> {
  ObscureFormCubit() : super(true);

  void change(bool obscure) {
    emit(obscure);
  }
}
