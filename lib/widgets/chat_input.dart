import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/chat_input_cubit.dart';
import 'package:moodly/shared/theme.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({
    Key? key,
    required this.chatController,
    this.isSendImage = false,
    required this.onTapMessage,
    required this.onTapImage,
  }) : super(key: key);

  final TextEditingController chatController;
  final bool isSendImage;
  final Function() onTapMessage;
  final Function() onTapImage;

  @override
  Widget build(BuildContext context) {
    ChatInputCubit chatInputCubit = context.read<ChatInputCubit>();
    chatInputCubit.chageText(''); //default
    chatController.addListener(() {
      chatInputCubit.chageText(chatController.text);
    });

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: white,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: chatController,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              minLines: 1,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                hintText: 'Write message...',
                hintStyle: greyText,
                focusColor: primaryColor,
                contentPadding: const EdgeInsets.all(8),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(defaultRadius)),
                  borderSide: BorderSide(color: grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          BlocBuilder<ChatInputCubit, String>(
            bloc: chatInputCubit,
            builder: (context, state) {
              return (state.replaceAll(' ', '').isNotEmpty || isSendImage)
                  ? Material(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(defaultRadius),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(defaultRadius),
                        onTap: onTapMessage,
                        child: SizedBox(
                          width: 45,
                          height: 45,
                          child: Center(
                            child: Icon(
                              Icons.send,
                              color: white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Material(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(defaultRadius),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(defaultRadius),
                        onTap: onTapImage,
                        child: SizedBox(
                          width: 45,
                          height: 45,
                          child: Center(
                            child: Icon(
                              Icons.camera_alt,
                              color: white,
                            ),
                          ),
                        ),
                      ),
                    );
            },
          )
        ],
      ),
    );
  }
}
