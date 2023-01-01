part of 'consultant_save_cubit.dart';

abstract class ConsultantSaveState extends Equatable {
  const ConsultantSaveState();

  @override
  List<Object> get props => [];
}

class ConsultantSaveInitial extends ConsultantSaveState {}

class ConsultantSaveLoading extends ConsultantSaveState {}

class ConsultantSaveSuccess extends ConsultantSaveState {}

class ConsultantSaveFailed extends ConsultantSaveState {
  const ConsultantSaveFailed(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
