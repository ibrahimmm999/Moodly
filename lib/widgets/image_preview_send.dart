import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moodly/cubit/image_file_cubit.dart';
import 'package:moodly/cubit/send_chat_cubit.dart';
import 'package:moodly/service/image_service.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/chat_input.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewSend extends StatelessWidget {
  const ImagePreviewSend(
      {required this.isSupportChat,
      required this.imageFile,
      this.isUser = true,
      this.userIdAdmin = '',
      super.key});

  final bool isSupportChat;
  final bool isUser;
  final File imageFile;
  final String userIdAdmin;

  @override
  Widget build(BuildContext context) {
    TextEditingController chatController = TextEditingController(text: '');
    String userIdUser = FirebaseAuth.instance.currentUser!.uid;
    ImageTool imageTool = ImageTool();

    ImageFileCubit imageFileCubit = context.read<ImageFileCubit>();
    imageFileCubit.changeImageFile(imageFile);

    SendChatCubit sendChatCubit = context.read<SendChatCubit>();

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
          'Send Image',
          style: primaryColorText.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await imageTool.cropImage(imageFile: imageFile);
                imageFileCubit.changeImageFile(imageTool.croppedImageFile);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: primaryColor,
                    content: Text(e.toString()),
                  ),
                );
              }
            },
            icon: const Icon(Icons.crop),
            color: primaryColor,
            iconSize: 16,
          ),
        ],
      );
    }

    Widget content() {
      return BlocBuilder<ImageFileCubit, File?>(
        bloc: imageFileCubit,
        builder: (context, state) {
          return PhotoView(
            imageProvider:
                state == null ? FileImage(imageFile) : FileImage(state),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: white2,
      appBar: header(),
      body: Column(
        children: [
          Expanded(child: content()),
          BlocConsumer<SendChatCubit, SendChatState>(
            bloc: sendChatCubit,
            listener: (context, state) {
              if (state is SendChatSuccess) {
                Navigator.pop(context);
              } else if (state is SendChatFailed) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: primaryColor,
                    content: Text(state.error),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is SendChatLoading) {
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: primaryColor,
                    size: 55,
                  ),
                );
              }
              return ChatInput(
                isSendImage: true,
                chatController: chatController,
                onTapImage: () {},
                onTapMessage: () async {
                  if (isSupportChat) {
                    sendChatCubit.sendImageSupport(
                      imageFile: imageFileCubit.state!,
                      text: chatController.text.trim(),
                      userId: isUser ? userIdUser : userIdAdmin,
                      isUser: isUser,
                    );
                  } else {
                    sendChatCubit.sendImageHelp(
                      imageFile: imageFileCubit.state!,
                      text: chatController.text.trim(),
                      userId: isUser ? userIdUser : userIdAdmin,
                      isUser: isUser,
                    );
                  }
                  chatController.clear();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              );
            },
          )
        ],
      ),
    );
  }
}
