part of 'tracking_cubit.dart';

abstract class TrackingState extends Equatable {
  const TrackingState();

  @override
  List<Object> get props => [];
}

class TrackingInitial extends TrackingState {}

class TrackingLoading extends TrackingState {}

class TrackingSuccess extends TrackingState {}

class TrackingFailed extends TrackingState {
  const TrackingFailed(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
