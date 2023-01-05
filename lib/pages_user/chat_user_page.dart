import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moodly/models/help_chat_model.dart';
import 'package:moodly/models/support_chat_model.dart';
import 'package:moodly/models/user_model.dart';
import 'package:moodly/service/chat_service.dart';
import 'package:moodly/service/image_service.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/chat_bubble.dart';
import 'package:moodly/widgets/chat_input.dart';
import 'package:moodly/widgets/image_preview_send.dart';
import 'package:moodly/cubit/status_help_cubit.dart';

class ChatUserPage extends StatelessWidget {
  const ChatUserPage({required this.isSupportChat, super.key});

  final bool isSupportChat;

  @override
  Widget build(BuildContext context) {
    TextEditingController chatController = TextEditingController(text: '');
    ScrollController scrollController = ScrollController();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    ChatService chatService = ChatService();
    ImageTool imageTool = ImageTool();
    StatusHelpCubit statusHelpCubit = context.read<StatusHelpCubit>();

    PreferredSizeWidget header() {
      return AppBar(
        toolbarHeight: 70,
        backgroundColor: white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: primaryColor,
          iconSize: 16,
        ),
        title: isSupportChat
            ? Text(
                'Support Messages',
                style: primaryColorText.copyWith(
                  fontSize: 18,
                  fontWeight: medium,
                ),
              )
            : Column(
                children: [
                  Text(
                    'Help Center',
                    style: darkText.copyWith(
                      fontSize: 18,
                      fontWeight: medium,
                    ),
                  ),
                  BlocBuilder<StatusHelpCubit, bool>(
                    bloc: statusHelpCubit,
                    builder: (context, state) {
                      return !state
                          ? Text(
                              'Uncomplete Status',
                              style: primaryColorText.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            )
                          : Text(
                              'Complete Status',
                              style: secondaryColorText.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            );
                    },
                  ),
                ],
              ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget chat() {
      return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var chats = [];
              if (isSupportChat) {
                chats = UserModel.fromJson(
                        snapshot.data!.data() as Map<String, dynamic>)
                    .supportChatList;
              } else {
                chats = UserModel.fromJson(
                        snapshot.data!.data() as Map<String, dynamic>)
                    .helpChatList;
                if (chats.isNotEmpty) {
                  statusHelpCubit.changeStatus(chats.last.isCompleted);
                }
              }
              return ListView(
                controller: scrollController,
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                children: chats
                    .map((e) => ChatBubble(
                          date: e.date,
                          text: e.message,
                          imageUrl: e.imageUrl,
                          isSender: e.isUser,
                        ))
                    .toList(),
              );
            }
            return Center(
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: secondaryColor,
                rightDotColor: primaryColor,
                size: 60,
              ),
            );
          });
    }

    Widget content() {
      return Column(
        children: [
          Expanded(child: chat()),
          ChatInput(
            chatController: chatController,
            onTapImage: () async {
              try {
                final navigator = Navigator.of(context);
                await imageTool.pickImageNotCrop();
                if (imageTool.imagetFile != null) {
                  navigator.push(
                    MaterialPageRoute(
                      builder: (context) => ImagePreviewSend(
                        imageFile: imageTool.imagetFile!,
                        isSupportChat: isSupportChat,
                      ),
                    ),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: primaryColor,
                    content: Text(e.toString()),
                  ),
                );
              }
            },
            onTapMessage: () async {
              try {
                if (isSupportChat) {
                  await chatService.addSupportChat(
                    SupportChatModel(
                      date: Timestamp.now(),
                      message: chatController.text.trim(),
                    ),
                    userId,
                  );
                } else {
                  await chatService.addHelpChat(
                    HelpChatModel(
                      date: Timestamp.now(),
                      message: chatController.text.trim(),
                    ),
                    userId,
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: primaryColor,
                    content: Text(e.toString()),
                  ),
                );
              }
              await scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut);
              chatController.clear();
            },
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: white2,
      appBar: header(),
      body: content(),
    );
  }
}
