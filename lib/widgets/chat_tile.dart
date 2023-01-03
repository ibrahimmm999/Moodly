import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/status_help_cubit.dart';
import 'package:moodly/pages_admin/chat_admin_page.dart';
import 'package:moodly/service/chat_service.dart';
import 'package:moodly/service/time_converter.dart';
import 'package:moodly/shared/theme.dart';

class ChatTile extends StatelessWidget {
  const ChatTile(
      {required this.name,
      required this.photoUrl,
      required this.userId,
      required this.lastMessage,
      required this.lastDate,
      this.isCompleted = false,
      this.isHelpMessage = false,
      this.unreadCount = 0,
      Key? key})
      : super(key: key);

  final String photoUrl;
  final String name;
  final String userId;
  final String lastMessage;
  final Timestamp lastDate;
  final int unreadCount;
  final bool isCompleted;
  final bool isHelpMessage;

  @override
  Widget build(BuildContext context) {
    StatusHelpCubit statusHelpCubit = context.read<StatusHelpCubit>();
    statusHelpCubit.changeStatus(isCompleted);
    ChatService chatService = ChatService();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatAdminPage(
              isSupportChat: !isHelpMessage,
              name: name,
              photoUrl: photoUrl,
              userId: userId,
            ),
          ),
        );
        chatService.updateRead(userId, isHelpMessage);
      },
      child: Container(
        margin: const EdgeInsets.only(
          top: 16,
        ),
        child: Column(
          children: [
            Row(
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: darkText.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        lastMessage.replaceAll("\n", " "),
                        style: greyText.copyWith(
                          fontWeight: light,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      isHelpMessage
                          ? BlocBuilder<StatusHelpCubit, bool>(
                              bloc: statusHelpCubit,
                              builder: (context, state) {
                                return Material(
                                  color: state ? secondaryColor : primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius),
                                  child: InkWell(
                                    onTap: () {
                                      statusHelpCubit.changeStatus(!state);
                                      ChatService()
                                          .updateHelpStatus(userId, !state);
                                    },
                                    borderRadius:
                                        BorderRadius.circular(defaultRadius),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      child: state
                                          ? Text(
                                              'Completed',
                                              style: whiteText.copyWith(
                                                  fontSize: 8),
                                            )
                                          : Text(
                                              'Uncompleted',
                                              style: whiteText.copyWith(
                                                  fontSize: 8),
                                            ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                Row(
                  children: [
                    unreadCount == 0
                        ? const SizedBox()
                        : Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: dark),
                            child: Center(
                              child: Text(
                                unreadCount.toString(),
                                style: whiteText,
                              ),
                            ),
                          ),
                    Text(
                      ConvertTime().convertToAgo(lastDate),
                      style: greyText.copyWith(fontSize: 10),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Divider(
              thickness: 1,
              color: grey.withOpacity(0.5),
            )
          ],
        ),
      ),
    );
  }
}
