import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moodly/service/time_converter.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/image_preview.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {Key? key,
      this.isSender = false,
      this.text = '',
      this.imageUrl = '',
      required this.date})
      : super(key: key);

  final String text;
  final String imageUrl;
  final bool isSender;
  final Timestamp date;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 16,
      ),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSender ? secondaryColor : primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isSender ? 12 : 0),
                      topRight: Radius.circular(isSender ? 0 : 12),
                      bottomLeft: const Radius.circular(12),
                      bottomRight: const Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: isSender
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      imageUrl.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ImagePreview(imageUrl: imageUrl),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(isSender ? 12 : 0),
                                    topRight:
                                        Radius.circular(isSender ? 0 : 12),
                                    bottomLeft: const Radius.circular(12),
                                    bottomRight: const Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    imageUrl,
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      text.isNotEmpty
                          ? Text(
                              text,
                              style: whiteText,
                            )
                          : const SizedBox(),
                      Text(
                        ConvertTime().convertToAgo(date),
                        style: whiteText.copyWith(
                          fontWeight: regular,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
