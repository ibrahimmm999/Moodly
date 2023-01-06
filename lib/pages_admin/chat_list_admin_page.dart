import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/chat_admin_page_cubit.dart';
import 'package:moodly/cubit/unread_help_cubit.dart';
import 'package:moodly/cubit/unread_support_cubit.dart';
import 'package:moodly/models/user_model.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/chat_tile.dart';

class ChatListAdminPage extends StatelessWidget {
  const ChatListAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    // INISIALISASI
    ChatAdminPageCubit chatAdminPageCubit = context.read<ChatAdminPageCubit>();
    UnreadSupportCubit unreadSupportCubit = context.read<UnreadSupportCubit>();
    UnreadHelpCubit unreadHelpCubit = context.read<UnreadHelpCubit>();

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
                    Row(
                      children: [
                        Text(
                          'Support Messages',
                          style: index == 0 ? primaryColorText : greyText,
                        ),
                        BlocBuilder<UnreadSupportCubit, int>(
                          builder: (context, state) {
                            return Visibility(
                              visible: state != 0,
                              child: Container(
                                margin: const EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor,
                                ),
                                child: Text(
                                  state.toString(),
                                  style: whiteText.copyWith(
                                    fontWeight: medium,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
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
                    Row(
                      children: [
                        Text(
                          'Help Center',
                          style: index == 1 ? primaryColorText : greyText,
                        ),
                        BlocBuilder<UnreadHelpCubit, int>(
                          builder: (context, state) {
                            return Visibility(
                              visible: state != 0,
                              child: Container(
                                margin: const EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor,
                                ),
                                child: Text(
                                  state.toString(),
                                  style: whiteText.copyWith(
                                    fontWeight: medium,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
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

    Widget chatList(int index) {
      return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var users = snapshot.data!.docs
                  .map((e) => UserModel.fromJson(e.data()))
                  .toList();

              var unreadHelp = 0;
              var unreadSupport = 0;
              for (var element in users) {
                for (var a in element.helpChatList) {
                  if (!(a.isRead)) {
                    unreadHelp += 1;
                  }
                }
                for (var a in element.supportChatList) {
                  if (!(a.isRead)) {
                    unreadSupport += 1;
                  }
                }
              }
              unreadHelpCubit.change(unreadHelp);
              unreadSupportCubit.change(unreadSupport);

              if (index == 0) {
                users.removeWhere((element) => element.supportChatList.isEmpty);
                users.sort((a, b) {
                  if (a.supportChatList.last.isRead !=
                      b.supportChatList.last.isRead) {
                    if (a.supportChatList.last.isRead) {
                      return 1;
                    } else {
                      return -1;
                    }
                  } else {
                    return b.supportChatList.last.date
                        .compareTo(a.supportChatList.last.date);
                  }
                });

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
                              photoUrl: e.photoUrl,
                              unreadCount: unread,
                              lastMessage: e.supportChatList.last.message,
                              lastDate: e.supportChatList.last.date,
                            );
                          }).toList(),
                        ),
                      );
              } else {
                users.removeWhere((element) => element.helpChatList.isEmpty);
                users.sort((a, b) {
                  if (a.helpChatList.last.isCompleted !=
                      b.helpChatList.last.isCompleted) {
                    if (a.helpChatList.last.isCompleted) {
                      return 1;
                    } else {
                      return -1;
                    }
                  } else {
                    if (a.helpChatList.last.isRead !=
                        b.helpChatList.last.isRead) {
                      if (a.helpChatList.last.isRead) {
                        return 1;
                      } else {
                        return -1;
                      }
                    } else {
                      return b.helpChatList.last.date
                          .compareTo(a.helpChatList.last.date);
                    }
                  }
                });
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
                              photoUrl: e.photoUrl,
                              unreadCount: unread,
                              lastMessage: e.helpChatList.last.message,
                              lastDate: e.helpChatList.last.date,
                              isHelpMessage: true,
                              isCompleted: e.helpChatList.last.isCompleted,
                            );
                          }).toList(),
                        ),
                      );
              }
            }
            return const SizedBox();
          });
    }

    return Scaffold(
      backgroundColor: white2,
      appBar: header(),
      body: BlocBuilder<ChatAdminPageCubit, int>(
        builder: (context, state) {
          return Column(
            children: [
              switchContent(state),
              chatList(state),
            ],
          );
        },
      ),
    );
  }
}
