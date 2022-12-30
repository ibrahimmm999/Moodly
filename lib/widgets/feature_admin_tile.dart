import 'package:flutter/material.dart';
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
                ? Row(
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
                          '10',
                          style: primaryColorText.copyWith(
                            fontWeight: medium,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
