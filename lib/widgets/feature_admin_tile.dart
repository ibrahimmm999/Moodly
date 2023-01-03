import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moodly/models/user_model.dart';
import 'package:moodly/shared/theme.dart';

class FeatureAdminTile extends StatelessWidget {
  const FeatureAdminTile({
    required this.onTap,
    required this.icon,
    required this.color,
    required this.subtitle,
    required this.title,
    this.isChat = false,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String subtitle;
  final String title;
  final bool isChat;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: EdgeInsets.only(bottom: defaultMargin),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 44,
                    color: white,
                  ),
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        subtitle,
                        style: whiteText.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                      Text(
                        title,
                        style: whiteText.copyWith(
                          fontWeight: semibold,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            isChat
                ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        var users = snapshot.data!.docs
                            .map((e) => UserModel.fromJson(e.data()))
                            .toList();
                        var unread = 0;
                        for (var element in users) {
                          for (var a in element.helpChatList) {
                            if (!(a.isRead)) {
                              unread += 1;
                            }
                          }
                          for (var a in element.supportChatList) {
                            if (!(a.isRead)) {
                              unread += 1;
                            }
                          }
                        }
                        return unread == 0
                            ? const SizedBox()
                            : Row(
                                children: [
                                  Text('unread', style: whiteText),
                                  Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: white,
                                    ),
                                    child: Text(
                                      unread.toString(),
                                      style: primaryColorText.copyWith(
                                        fontWeight: medium,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              );
                      }
                      return Center(
                        child: LoadingAnimationWidget.twistingDots(
                          leftDotColor: secondaryColor,
                          rightDotColor: primaryColor,
                          size: 24,
                        ),
                      );
                    })
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
