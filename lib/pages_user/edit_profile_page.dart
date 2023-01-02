import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/auth_cubit.dart';
import 'package:moodly/cubit/image_file_cubit.dart';
import 'package:moodly/cubit/image_url_cubit.dart';
import 'package:moodly/service/image_service.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/custom_text_form_field.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage(
      {required this.id,
      required this.name,
      required this.photoUrl,
      required this.username,
      super.key});

  final String id;
  final String name;
  final String photoUrl;
  final String username;

  @override
  Widget build(BuildContext context) {
    // INISIALISASI
    ImageTool imageTool = ImageTool();
    ImageFileCubit imageFileCubit = context.read<ImageFileCubit>();
    imageFileCubit.changeImageFile(null);
    ImageUrlCubit imageUrlCubit = context.read<ImageUrlCubit>();
    imageUrlCubit.changeImageUrl(photoUrl);

    AuthCubit authCubit = context.read<AuthCubit>();

    final TextEditingController fullNameController =
        TextEditingController(text: name);
    final TextEditingController usernameController =
        TextEditingController(text: username);

    PreferredSizeWidget header() {
      return AppBar(
        toolbarHeight: 70,
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: primaryColorText.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          BlocConsumer<AuthCubit, AuthState>(
            bloc: authCubit,
            listener: (context, state) {
              if (state is AuthSuccess) {
                Navigator.pop(context);
              } else if (state is AuthFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: primaryColor,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: Center(
                    child: CircularProgressIndicator(color: dark),
                  ),
                );
              }
              return IconButton(
                onPressed: () {
                  authCubit.updateUser(
                    id: id,
                    image: imageFileCubit.state,
                    name: fullNameController.text,
                    username: usernameController.text,
                    photoUrlState: imageUrlCubit.state,
                    tempPhoto: photoUrl,
                  );
                },
                icon: const Icon(Icons.check),
                color: secondaryColor,
              );
            },
          )
        ],
      );
    }

    Widget content() {
      Widget inputFullName() {
        return CustomTextFormField(
          icon: Icon(
            Icons.person_rounded,
            color: primaryColor,
          ),
          hintText: 'Your Full Name',
          controller: fullNameController,
          radiusBorder: defaultRadius,
        );
      }

      Widget inputUsername() {
        return CustomTextFormField(
          icon: Icon(
            Icons.radio_button_checked_rounded,
            color: primaryColor,
          ),
          hintText: 'Your Username',
          controller: usernameController,
          radiusBorder: defaultRadius,
        );
      }

      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          Center(
            child: BlocBuilder<ImageFileCubit, File?>(
              bloc: imageFileCubit,
              builder: (context, imageFile) {
                return BlocBuilder<ImageUrlCubit, String>(
                  bloc: imageUrlCubit,
                  builder: (context, imageUrl) {
                    DecorationImage imageProfile() {
                      if (imageFile == null) {
                        if (imageUrl.isEmpty) {
                          return const DecorationImage(
                            image: AssetImage('assets/profile_default.png'),
                            fit: BoxFit.cover,
                          );
                        } else {
                          return DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          );
                        }
                      } else {
                        return DecorationImage(
                          image: FileImage(imageFile),
                          fit: BoxFit.cover,
                        );
                      }
                    }

                    return Container(
                      margin: EdgeInsets.only(top: defaultMargin, bottom: 12),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: imageProfile(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: dark,
                borderRadius: BorderRadius.circular(defaultRadius),
                child: InkWell(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  onTap: () async {
                    try {
                      await imageTool.pickImage();
                      imageFileCubit.changeImageFile(imageTool.imagetFile);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: primaryColor,
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  },
                  child: SizedBox(
                    width: 50,
                    height: 35,
                    child: Icon(Icons.edit, color: white, size: 20),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Material(
                color: primaryColor,
                borderRadius: BorderRadius.circular(defaultRadius),
                child: InkWell(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  onTap: () {
                    imageFileCubit.changeImageFile(null);
                    imageUrlCubit.changeImageUrl('');
                  },
                  child: SizedBox(
                    width: 50,
                    height: 35,
                    child: Icon(Icons.delete, color: white, size: 20),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Full Name",
            style: darkText.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(height: 12),
          inputFullName(),
          const SizedBox(height: 20),
          Text(
            "Username",
            style: darkText.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(height: 12),
          inputUsername(),
          const SizedBox(height: 20),
        ],
      );
    }

    return Scaffold(
      backgroundColor: white2,
      appBar: header(),
      body: content(),
    );
  }
}
