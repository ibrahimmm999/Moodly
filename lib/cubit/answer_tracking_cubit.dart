import 'package:bloc/bloc.dart';

class AnswerTrackingCubit extends Cubit<List<String>> {
  AnswerTrackingCubit() : super([]);
  void selectAnswer(String answer, int i) {
    if (state.isEmpty) {
      state.add(answer);
    } else {
      if (answer == " ") {
        state.add(answer);
      } else {
        if (!isSelected(answer, i)) {
          state[i] = answer;
        }
      }
    }
    emit(List.from(state));
  }

  bool isSelected(String answer, int i) {
    if (answer == state[i]) {
      return true;
    } else {
      return false;
    }
  }
}
