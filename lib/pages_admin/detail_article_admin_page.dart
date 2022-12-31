import 'package:flutter/material.dart';
import 'package:moodly/widgets/form_consultant_article.dart';

import '../shared/theme.dart';

class DetailArticleAdminPage extends StatelessWidget {
  DetailArticleAdminPage({super.key});

  final TextEditingController titleController = TextEditingController(text: '');
  final TextEditingController contentController =
      TextEditingController(text: '');
  final TextEditingController authorController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return AppBar(
        toolbarHeight: 70,
        backgroundColor: white,
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10, bottom: 3),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home-admin');
              },
              icon: const Icon(
                Icons.check_rounded,
              ),
              iconSize: 24,
              color: secondaryColor,
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: primaryColor,
          iconSize: 16,
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
        return Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/example/article1_example.png"))),
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
                onTap: () {},
                child: SizedBox(
                  width: 42,
                  height: 26,
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

    return Scaffold(appBar: header(), body: content());
  }
}
