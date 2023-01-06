import 'package:bloc/bloc.dart';

class StatusRecomendationCubit extends Cubit<bool> {
  StatusRecomendationCubit() : super(false);

  void changeStatus(bool status) {
    emit(status);
  }
}
