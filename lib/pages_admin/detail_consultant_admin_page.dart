import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/consultant_save_cubit.dart';
import 'package:moodly/cubit/image_file_cubit.dart';
import 'package:moodly/models/consultant_model.dart';
import 'package:moodly/service/image_service.dart';
import 'package:moodly/widgets/form_consultant_article.dart';

import '../shared/theme.dart';

class DetailConsultantAdminPage extends StatelessWidget {
  const DetailConsultantAdminPage({
    this.id = '',
    this.photoUrl = '',
    this.name = '',
    this.phone = '',
    this.openTime = '',
    this.address = '',
    this.province = '',
    super.key,
  });

  final String id;
  final String photoUrl;
  final String name;
  final String phone;
  final String openTime;
  final String address;
  final String province;

  @override
  Widget build(BuildContext context) {
    // Inisialisasi
    final TextEditingController nameController =
        TextEditingController(text: name);
    final TextEditingController phoneController =
        TextEditingController(text: phone);
    final TextEditingController openTimeController =
        TextEditingController(text: openTime);
    final TextEditingController addressController =
        TextEditingController(text: address);

    ImageTool imageTool = ImageTool();

    ImageFileCubit imageFileCubit = context.read<ImageFileCubit>();
    imageFileCubit.changeImageFile(null);

    ConsultantSaveCubit consultantSaveCubit =
        context.read<ConsultantSaveCubit>();

    String newProvince = 'Ngayogayakarta';

    PreferredSizeWidget header() {
      return AppBar(
        toolbarHeight: 70,
        backgroundColor: white,
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10, bottom: 3),
            child: BlocConsumer<ConsultantSaveCubit, ConsultantSaveState>(
              bloc: consultantSaveCubit,
              listener: (context, state) {
                if (state is ConsultantSaveSuccess) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data saved successfully!'),
                    ),
                  );
                } else if (state is ConsultantSaveFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: primaryColor,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is ConsultantSaveLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: dark),
                  );
                }
                return IconButton(
                  onPressed: () {
                    consultantSaveCubit.save(
                      image: imageFileCubit.state,
                      consultant: ConsultantModel(
                        id: id,
                        name: nameController.text,
                        photoUrl: photoUrl,
                        phone: phoneController.text,
                        openTime: openTimeController.text,
                        address: addressController.text,
                        province: newProvince,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.check_rounded,
                  ),
                  iconSize: 24,
                  color: secondaryColor,
                );
              },
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear_rounded),
          iconSize: 24,
          color: primaryColor,
        ),
        title: Text(
          'Add Consultant',
          style: primaryColorText.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget content() {
      Widget banner() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ImageFileCubit, File?>(
              builder: (context, imageFile) {
                DecorationImage imageThumbnail() {
                  if (imageFile == null) {
                    if (photoUrl.isEmpty) {
                      return const DecorationImage(
                        image: AssetImage("assets/empty_image.png"),
                        fit: BoxFit.cover,
                      );
                    } else {
                      return DecorationImage(
                        image: NetworkImage(photoUrl),
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
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: imageThumbnail(),
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                );
              },
            ),
          ],
        );
      }

      Widget inputName() {
        return FormConsultantAndArticle(
            controller: nameController, minlines: 1, title: 'Name');
      }

      Widget inputPhone() {
        return FormConsultantAndArticle(
            controller: phoneController, minlines: 1, title: 'Phone');
      }

      Widget inputOpenTime() {
        return FormConsultantAndArticle(
            controller: openTimeController, minlines: 1, title: 'Open Time');
      }

      Widget inputAddress() {
        return FormConsultantAndArticle(
            controller: addressController, minlines: 1, title: 'Address');
      }

      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 24),
        children: [
          banner(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 140, vertical: 12),
            child: Material(
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
          ),
          Text('Name', style: darkText.copyWith(fontSize: 16)),
          const SizedBox(height: 10),
          inputName(),
          const SizedBox(height: 20),
          Text('Phone', style: darkText.copyWith(fontSize: 16)),
          const SizedBox(height: 10),
          inputPhone(),
          const SizedBox(height: 20),
          Text('Open Time', style: darkText.copyWith(fontSize: 16)),
          const SizedBox(height: 10),
          inputOpenTime(),
          const SizedBox(height: 20),
          Text('Address', style: darkText.copyWith(fontSize: 16)),
          const SizedBox(height: 10),
          inputAddress(),
          const SizedBox(height: 20)
        ],
      );
    }

    return Scaffold(
      appBar: header(),
      body: content(),
    );
  }
}
