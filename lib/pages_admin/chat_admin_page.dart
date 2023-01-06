import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moodly/cubit/status_recomendation_cubit.dart';
import 'package:moodly/models/help_chat_model.dart';
import 'package:moodly/models/support_chat_model.dart';
import 'package:moodly/models/user_model.dart';
import 'package:moodly/service/chat_service.dart';
import 'package:moodly/service/image_service.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/chat_bubble.dart';
import 'package:moodly/widgets/chat_input.dart';
import 'package:moodly/widgets/image_preview_send.dart';

class ChatAdminPage extends StatelessWidget {
  const ChatAdminPage(
      {required this.isSupportChat,
      required this.userId,
      required this.name,
      required this.photoUrl,
      super.key});

  final bool isSupportChat;
  final String userId;
  final String name;
  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    TextEditingController chatController = TextEditingController(text: '');
    ScrollController scrollController = ScrollController();
    ChatService chatService = ChatService();
    ImageTool imageTool = ImageTool();
    StatusRecomendationCubit statusRecomendationCubit =
        context.read<StatusRecomendationCubit>();
    statusRecomendationCubit.changeStatus(false);

    PreferredSizeWidget header() {
      return AppBar(
        toolbarHeight: 70,
        backgroundColor: white,
        leading: IconButton(
          onPressed: () {
            chatService.updateRead(userId, !isSupportChat);
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: primaryColor,
          iconSize: 16,
        ),
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: photoUrl.isEmpty
                  ? Image.asset(
                      'assets/profile_default.png',
                      width: 54,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      photoUrl,
                      width: 54,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              name,
              style: primaryColorText.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
          ],
        ),
        actions: [
          Visibility(
            visible: !isSupportChat,
            child: IconButton(
              onPressed: () async {
                try {
                  await ChatService().updateRecomendation(
                      userId, !statusRecomendationCubit.state);
                } catch (e) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                      backgroundColor: primaryColor,
                    ),
                  );
                }
              },
              icon: Icon(
                Icons.group,
                color: dark,
              ),
            ),
          )
        ],
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
                  statusRecomendationCubit
                      .changeStatus(chats.last.isRecomendation);
                }
              }
              Timer(
                Duration.zero,
                () => scrollController.jumpTo(
                  scrollController.position.maxScrollExtent,
                ),
              );
              return ListView(
                controller: scrollController,
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                children: chats
                    .map((e) => ChatBubble(
                          date: e.date,
                          text: e.message,
                          imageUrl: e.imageUrl,
                          isSender: !e.isUser,
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
                        isUser: false,
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
                      isUser: false,
                    ),
                    userId,
                  );
                } else {
                  await chatService.addHelpChat(
                    HelpChatModel(
                      date: Timestamp.now(),
                      message: chatController.text.trim(),
                      isUser: false,
                      isRecomendation: statusRecomendationCubit.state,
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
              Timer(
                Duration.zero,
                () => scrollController.jumpTo(
                  scrollController.position.maxScrollExtent,
                ),
              );
              chatController.clear();
            },
          ),
        ],
      );
    }

    Widget recomendation() {
      return BlocBuilder<StatusRecomendationCubit, bool>(
        bloc: statusRecomendationCubit,
        builder: (context, state) {
          return Visibility(
            visible: state && !isSupportChat,
            child: Container(
              margin:
                  EdgeInsets.symmetric(vertical: 8, horizontal: defaultMargin),
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultRadius),
                color: dark,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Consultants Recomendation",
                    style: whiteText,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/consultant-user');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'View',
                      style: whiteText.copyWith(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: white2,
      appBar: header(),
      body: Stack(
        children: [
          content(),
          recomendation(),
        ],
      ),
    );
  }
}
