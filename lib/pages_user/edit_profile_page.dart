import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/image_file_cubit.dart';
import 'package:moodly/service/image_service.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/custom_text_form_field.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  final TextEditingController fullNameController =
      TextEditingController(text: '');
  final TextEditingController usernameController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    // INISIALISASI
    ImageTool imageTool = ImageTool();
    ImageFileCubit imageFileCubit = context.read<ImageFileCubit>();
    imageFileCubit.changeImageFile(null);

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
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check),
            color: secondaryColor,
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

      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: BlocBuilder<ImageFileCubit, File?>(
                builder: (context, imageFile) {
                  DecorationImage imageProfile() {
                    if (imageFile == null) {
                      return const DecorationImage(
                        image: AssetImage('assets/example/user_profile.png'),
                        fit: BoxFit.cover,
                      );
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
        ),
      );
    }

    return Scaffold(
      backgroundColor: white2,
      appBar: header(),
      body: content(),
    );
  }
}
