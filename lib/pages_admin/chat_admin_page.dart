import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    ChatService chatService = ChatService();
    ImageTool imageTool = ImageTool();

    PreferredSizeWidget header() {
      return AppBar(
        toolbarHeight: 70,
        backgroundColor: white,
        leading: IconButton(
          onPressed: () {
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
              }
              return ListView(
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
                      message: chatController.text,
                      isUser: false,
                    ),
                    userId,
                  );
                } else {
                  await chatService.addHelpChat(
                    HelpChatModel(
                      date: Timestamp.now(),
                      message: chatController.text,
                      isUser: false,
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
              chatController.clear();
              FocusManager.instance.primaryFocus?.unfocus();
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
