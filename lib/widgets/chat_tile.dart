import 'package:flutter/material.dart';
import 'package:moodly/shared/theme.dart';

class ChatTile extends StatelessWidget {
  const ChatTile(
      {required this.name,
      required this.imageUrl,
      this.isCompleted = false,
      this.isHelpMessage = false,
      Key? key})
      : super(key: key);

  final String imageUrl;
  final String name;
  final bool isCompleted;
  final bool isHelpMessage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                  child: Image.asset(
                    'assets/example/user_profile.png',
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
                        'ini last messege'.replaceAll("\n", " "),
                        style: greyText.copyWith(
                          fontWeight: light,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      isHelpMessage
                          ? Material(
                              color:
                                  isCompleted ? secondaryColor : primaryColor,
                              borderRadius:
                                  BorderRadius.circular(defaultRadius),
                              child: InkWell(
                                onTap: () {},
                                borderRadius:
                                    BorderRadius.circular(defaultRadius),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  child: isCompleted
                                      ? Text(
                                          'Completed',
                                          style:
                                              whiteText.copyWith(fontSize: 8),
                                        )
                                      : Text(
                                          'Uncompleted',
                                          style:
                                              whiteText.copyWith(fontSize: 8),
                                        ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(8),
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: dark),
                      child: Text(
                        '3',
                        style: whiteText,
                      ),
                    ),
                    Text(
                      '12.00',
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
