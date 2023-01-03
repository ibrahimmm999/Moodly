import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moodly/cubit/chat_admin_page_cubit.dart';
import 'package:moodly/models/user_model.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/chat_tile.dart';

class ChatListAdminPage extends StatelessWidget {
  const ChatListAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    // INISIALISASI
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
      return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('supportChatList', isNotEqualTo: []).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var users = snapshot.data!.docs
                  .map((e) => UserModel.fromJson(e.data()))
                  .toList();
              users.sort((b, a) => a.supportChatList.last.date
                  .compareTo(b.supportChatList.last.date));
              return users.isEmpty
                  ? emptyChat()
                  : Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        children: users.map((e) {
                          int unread = 0;
                          for (var element in e.supportChatList) {
                            if (!(element.isRead)) {
                              unread += 1;
                            }
                          }
                          return ChatTile(
                            userId: e.id,
                            name: e.name,
                            imageUrl: e.photoUrl,
                            unreadCount: unread,
                            lastMessage: e.supportChatList.last.message,
                            lastDate: e.supportChatList.last.date,
                          );
                        }).toList(),
                      ),
                    );
            }
            return Expanded(
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: secondaryColor,
                rightDotColor: primaryColor,
                size: 60,
              ),
            );
          });
    }

    Widget helpChat() {
      return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('helpChatList', isNotEqualTo: []).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var users = snapshot.data!.docs
                  .map((e) => UserModel.fromJson(e.data()))
                  .toList();
              users.sort((b, a) =>
                  a.helpChatList.last.date.compareTo(b.helpChatList.last.date));
              return users.isEmpty
                  ? emptyChat()
                  : Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        children: users.map((e) {
                          int unread = 0;
                          for (var element in e.helpChatList) {
                            if (!(element.isRead)) {
                              unread += 1;
                            }
                          }
                          return ChatTile(
                            userId: e.id,
                            name: e.name,
                            imageUrl: e.photoUrl,
                            unreadCount: unread,
                            lastMessage: e.helpChatList.last.message,
                            lastDate: e.helpChatList.last.date,
                          );
                        }).toList(),
                      ),
                    );
            }
            return Expanded(
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: secondaryColor,
                rightDotColor: primaryColor,
                size: 60,
              ),
            );
          });
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
