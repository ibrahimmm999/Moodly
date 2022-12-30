import 'package:flutter/material.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/chat_tile.dart';

class ChatListAdminPage extends StatelessWidget {
  const ChatListAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isEmptyChat = true;

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
          'Chats',
          style: primaryColorText.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget switchContent() {
      return SizedBox(
        width: double.infinity,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                color: white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Text(
                      'Support Messages',
                      style: primaryColorText,
                    ),
                    Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                color: white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Text(
                      'Help Center',
                      style: greyText,
                    ),
                    Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget emptyChat() {
      return Expanded(
        child: Container(
          width: double.infinity,
          color: white2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/headset.png',
                color: secondaryColor,
                width: 80,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Opss no message yet?',
                style: darkText.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Customers have never done a messages',
                style: greyText,
              ),
            ],
          ),
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: const [
            ChatTile(name: 'name', imageUrl: 'imageUrl'),
            ChatTile(name: 'name', imageUrl: 'imageUrl'),
            ChatTile(name: 'name', imageUrl: 'imageUrl'),
            ChatTile(name: 'name', imageUrl: 'imageUrl'),
            ChatTile(name: 'name', imageUrl: 'imageUrl'),
            ChatTile(name: 'name', imageUrl: 'imageUrl'),
            ChatTile(name: 'name', imageUrl: 'imageUrl'),
            ChatTile(name: 'name', imageUrl: 'imageUrl'),
            ChatTile(name: 'name', imageUrl: 'imageUrl'),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: white2,
      appBar: header(),
      body: Column(
        children: [
          switchContent(),
          // ignore: dead_code
          !isEmptyChat ? emptyChat() : content(),
        ],
      ),
    );
  }
}
