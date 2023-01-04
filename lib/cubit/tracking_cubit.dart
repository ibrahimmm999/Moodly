import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:moodly/service/question_service.dart';

part 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  TrackingCubit() : super(TrackingInitial());

  void saveQuestions(List<TextEditingController> listController) async {
    try {
      emit(TrackingLoading());
      await QuestionService().saveQuestion(listController);
      emit(TrackingSuccess());
    } catch (e) {
      emit(TrackingFailed(e.toString()));
    }
  }
}
