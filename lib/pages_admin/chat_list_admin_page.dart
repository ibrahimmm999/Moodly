import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/chat_admin_page_cubit.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/chat_tile.dart';

class ChatListAdminPage extends StatelessWidget {
  const ChatListAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    // INISIALISASI
    bool isEmptyHelpChat = false;
    bool isEmptySupportChat = false;
    ChatAdminPageCubit chatAdminPageCubit = context.read<ChatAdminPageCubit>();
    chatAdminPageCubit.changeChatAdminPage(0);

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

    Widget switchContent(int index) {
      return SizedBox(
        width: double.infinity,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                chatAdminPageCubit.changeChatAdminPage(0);
              },
              child: Container(
                color: white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Text(
                      'Support Messages',
                      style: index == 0 ? primaryColorText : greyText,
                    ),
                    Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: index == 0 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                chatAdminPageCubit.changeChatAdminPage(1);
              },
              child: Container(
                color: white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Text(
                      'Help Center',
                      style: index == 1 ? primaryColorText : greyText,
                    ),
                    Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: index == 1 ? primaryColor : Colors.transparent,
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

    Widget supportChat() {
      return isEmptySupportChat
          // ignore: dead_code
          ? emptyChat()
          // ignore: dead_code
          : Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: const [
                  ChatTile(name: 'name', imageUrl: 'imageUrl', unreadCount: 3),
                  ChatTile(name: 'name', imageUrl: 'imageUrl', unreadCount: 5),
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

    Widget helpChat() {
      return isEmptyHelpChat
          // ignore: dead_code
          ? emptyChat()
          // ignore: dead_code
          : Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: const [
                  ChatTile(
                    name: 'name',
                    imageUrl: 'imageUrl',
                    isHelpMessage: true,
                    isCompleted: false,
                  ),
                  ChatTile(
                    name: 'name',
                    imageUrl: 'imageUrl',
                    isHelpMessage: true,
                    isCompleted: true,
                  ),
                ],
              ),
            );
    }

    Widget content(int index) {
      switch (index) {
        case 0:
          return supportChat();
        case 1:
          return helpChat();
        default:
          return supportChat();
      }
    }

    return Scaffold(
      backgroundColor: white2,
      appBar: header(),
      body: BlocBuilder<ChatAdminPageCubit, int>(
        builder: (context, state) {
          return Column(
            children: [
              switchContent(state),
              content(state),
            ],
          );
        },
      ),
    );
  }
}
