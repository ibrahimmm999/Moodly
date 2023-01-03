part of 'send_chat_cubit.dart';

abstract class SendChatState extends Equatable {
  const SendChatState();

  @override
  List<Object> get props => [];
}

class SendChatInitial extends SendChatState {}

class SendChatLoading extends SendChatState {}

class SendChatSuccess extends SendChatState {}

class SendChatFailed extends SendChatState {
  const SendChatFailed(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
