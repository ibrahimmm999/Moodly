import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodly/models/support_chat_model.dart';
import 'package:moodly/service/chat_service.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/chat_bubble.dart';
import 'package:moodly/widgets/chat_input.dart';

class SupportChatUserPage extends StatelessWidget {
  const SupportChatUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController chatController = TextEditingController(text: '');
    String userId = FirebaseAuth.instance.currentUser!.uid;

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
        title: Text(
          'Support Messages',
          style: primaryColorText.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
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
              var supportChats = ((snapshot.data!.data()
                      as Map<String, dynamic>)['supportChatList'] as List)
                  .map((e) => SupportChatModel.fromJson(e))
                  .toList();
              return ListView(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                children: supportChats
                    .map((e) => ChatBubble(date: e.date, text: e.message))
                    .toList(),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: dark,
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
            onTapImage: () {},
            onTapMessage: () {
              ChatService().addSupportChat(
                SupportChatModel(
                  date: Timestamp.now(),
                  message: chatController.text,
                ),
                userId,
              );
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
