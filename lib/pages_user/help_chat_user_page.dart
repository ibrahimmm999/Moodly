import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/chat_bubble.dart';

class HelpChatUserPage extends StatelessWidget {
  const HelpChatUserPage({super.key});

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
        title: Column(
          children: [
            Text(
              'Help Center',
              style: darkText.copyWith(
                fontSize: 18,
                fontWeight: medium,
              ),
            ),
            Text(
              'Uncomplete Status',
              style: primaryColorText.copyWith(
                fontSize: 12,
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
        ],
      );
    }

    Widget chatInput() {
      return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: white,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: chatController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 1,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    hintText: 'Write message...',
                    hintStyle: greyText,
                    focusColor: primaryColor,
                    contentPadding: const EdgeInsets.all(8),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(defaultRadius)),
                      borderSide: BorderSide(color: grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(defaultRadius),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                  child: Image.asset(
                    'assets/send_button.png',
                    width: 45,
                  ),
                  onTap: () {
                    chatController.clear();
                    FocusManager.instance.primaryFocus?.unfocus();
                  }),
            ],
          ));
    }

    Widget content() {
      return Column(
        children: [
          Expanded(child: chat()),
          chatInput(),
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
