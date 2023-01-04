import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class QuestionFormCubit extends Cubit<List<TextEditingController>> {
  QuestionFormCubit() : super([]);

  void init(List<TextEditingController> listController) {
    emit(List.from(listController));
  }

  void addQuestion() {
    state.add(TextEditingController());
    emit(List.from(state));
  }

  void removeQuestion(int index) {
    state.removeAt(index);
    emit(List.from(state));
  }
}
