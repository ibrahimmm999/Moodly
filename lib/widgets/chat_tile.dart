import 'package:flutter/material.dart';
import 'package:moodly/shared/theme.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({required this.name, required this.imageUrl, Key? key})
      : super(key: key);

  final String imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(
          top: 24,
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
                      )
                    ],
                  ),
                ),
                Text(
                  '12.00',
                  style: greyText.copyWith(fontSize: 10),
                )
              ],
            ),
            const SizedBox(
              height: 12,
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
