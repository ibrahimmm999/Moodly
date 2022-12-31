import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/chat_bubble.dart';
import 'package:moodly/widgets/chat_input.dart';

class SupportChatUserPage extends StatelessWidget {
  const SupportChatUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController chatController = TextEditingController(text: '');

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
      return ListView(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        children: [
          ChatBubble(
            date: Timestamp.now(),
            text: 'halooo',
            isSender: true,
          ),
          ChatBubble(date: Timestamp.now(), text: 'halooo'),
          ChatBubble(date: Timestamp.now(), text: 'halooo'),
        ],
      );
    }

    Widget content() {
      return Column(
        children: [
          Expanded(child: chat()),
          ChatInput(chatController: chatController),
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
