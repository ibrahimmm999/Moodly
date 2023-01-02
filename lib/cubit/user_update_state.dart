part of 'user_update_cubit.dart';

abstract class UserUpdateState extends Equatable {
  const UserUpdateState();

  @override
  List<Object> get props => [];
}

class UserUpdateInitial extends UserUpdateState {}

class UserUpdateLoading extends UserUpdateState {}

class UserUpdateSuccess extends UserUpdateState {}

class UserUpdateFailed extends UserUpdateState {
  const UserUpdateFailed(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
