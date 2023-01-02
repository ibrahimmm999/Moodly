import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/chat_bubble.dart';
import 'package:moodly/widgets/chat_input.dart';
import 'package:moodly/widgets/image_bubble.dart';

class ChatAdminPage extends StatelessWidget {
  const ChatAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController chatController = TextEditingController(text: '');

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
              child: Image.asset(
                'assets/profile_default.png',
                width: 54,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              'Budiman',
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
          ImageBubble(
            date: Timestamp.now(),
            imageUrl: 'assets/example/article2_example.png',
          ),
          ImageBubble(
            date: Timestamp.now(),
            imageUrl: 'assets/example/article1_example.png',
            isSender: true,
          ),
        ],
      );
    }

    Widget content() {
      return Column(
        children: [
          Expanded(child: chat()),
          ChatInput(
            chatController: chatController,
            onTapImage: () {},
            onTapMessage: () {},
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
