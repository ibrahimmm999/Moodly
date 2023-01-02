import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/article_save_cubit.dart';
import 'package:moodly/cubit/image_file_cubit.dart';
import 'package:moodly/models/article_model.dart';
import 'package:moodly/service/image_service.dart';
import 'package:moodly/widgets/form_consultant_article.dart';

import '../shared/theme.dart';

class DetailArticleAdminPage extends StatelessWidget {
  const DetailArticleAdminPage({
    this.id = '',
    this.thumbnail = '',
    this.author = '',
    this.title = '',
    this.text = '',
    super.key,
  });

  final String id;
  final String thumbnail;
  final String title;
  final String author;
  final String text;

  @override
  Widget build(BuildContext context) {
    // Inisialisasi
    final TextEditingController titleController =
        TextEditingController(text: title);
    final TextEditingController contentController =
        TextEditingController(text: text);
    final TextEditingController authorController =
        TextEditingController(text: author);

    ImageTool imageTool = ImageTool();

    ImageFileCubit imageFileCubit = context.read<ImageFileCubit>();
    imageFileCubit.changeImageFile(null);

    ArticleSaveCubit articleSaveCubit = context.read<ArticleSaveCubit>();

    PreferredSizeWidget header() {
      return AppBar(
        toolbarHeight: 70,
        backgroundColor: white,
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10, bottom: 3),
            child: BlocConsumer<ArticleSaveCubit, ArticleSaveState>(
              bloc: articleSaveCubit,
              listener: (context, state) {
                if (state is ArticleSaveSuccess) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data saved successfully!'),
                    ),
                  );
                } else if (state is ArticleSaveFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: primaryColor,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is ArticleSaveLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: dark),
                  );
                }
                return IconButton(
                  onPressed: () {
                    articleSaveCubit.save(
                      image: imageFileCubit.state,
                      article: ArticleModel(
                        id: id,
                        title: titleController.text,
                        content: contentController.text,
                        author: authorController.text,
                        thumbnail: thumbnail,
                        date: Timestamp.now(),
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
          ),
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
          'Write Article',
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
                    if (thumbnail.isEmpty) {
                      return const DecorationImage(
                        image: AssetImage("assets/empty_image.png"),
                        fit: BoxFit.cover,
                      );
                    } else {
                      return DecorationImage(
                        image: NetworkImage(thumbnail),
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

      Widget inputTitle() {
        return FormConsultantAndArticle(
            controller: titleController, minlines: 1, title: 'Title');
      }

      Widget inputAuthor() {
        return FormConsultantAndArticle(
            controller: authorController, minlines: 1, title: 'Author');
      }

      Widget inputContent() {
        return FormConsultantAndArticle(
            controller: contentController, minlines: 14, title: 'Content');
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
          Text('Title', style: darkText.copyWith(fontSize: 16)),
          const SizedBox(height: 10),
          inputTitle(),
          const SizedBox(
            height: 20,
          ),
          Text('Author', style: darkText.copyWith(fontSize: 16)),
          const SizedBox(height: 10),
          inputAuthor(),
          const SizedBox(height: 20),
          Text(
            'Content',
            style: darkText.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          inputContent(),
          const SizedBox(
            height: 20,
          )
        ],
      );
    }

    return Scaffold(
      appBar: header(),
      body: content(),
    );
  }
}
