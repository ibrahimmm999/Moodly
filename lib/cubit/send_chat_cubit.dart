import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:moodly/models/help_chat_model.dart';
import 'package:moodly/models/support_chat_model.dart';
import 'package:moodly/service/chat_service.dart';
import 'package:moodly/service/image_service.dart';

part 'send_chat_state.dart';

class SendChatCubit extends Cubit<SendChatState> {
  SendChatCubit() : super(SendChatInitial());

  ImageTool imageTool = ImageTool();
  ChatService chatService = ChatService();

  void sendImageSupport({
    required File imageFile,
    required String text,
    required String userId,
    required bool isUser,
  }) async {
    try {
      emit(SendChatLoading());
      await imageTool.uploadImage(imageFile, 'chatImageSupport');
      await chatService.addSupportChat(
        SupportChatModel(
          date: Timestamp.now(),
          message: text,
          imageUrl: imageTool.imageUrl!,
          isUser: isUser,
        ),
        userId,
      );
      emit(SendChatSuccess());
    } catch (e) {
      emit(SendChatFailed(e.toString()));
    }
  }

  void sendImageHelp({
    required File imageFile,
    required String text,
    required String userId,
    required bool isUser,
  }) async {
    try {
      emit(SendChatLoading());
      await imageTool.uploadImage(imageFile, 'chatImageHelp');
      await chatService.addHelpChat(
        HelpChatModel(
          date: Timestamp.now(),
          message: text,
          imageUrl: imageTool.imageUrl!,
          isUser: isUser,
        ),
        userId,
      );
      emit(SendChatSuccess());
    } catch (e) {
      emit(SendChatFailed(e.toString()));
    }
  }
}
