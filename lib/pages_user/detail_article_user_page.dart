import 'package:flutter/material.dart';
import 'package:moodly/models/article_model.dart';

import '../service/time_converter.dart';
import '../shared/theme.dart';

class DetailArticleUserPage extends StatelessWidget {
  final ArticleModel article;
  const DetailArticleUserPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
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
          'Articles',
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
      Widget headerArticle() {
        return Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      overflow: TextOverflow.clip,
                      style: darkText.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      ConvertTime().convertToAgo(article.date),
                      style: secondaryColorText.copyWith(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      article.author,
                      style: primaryColorText.copyWith(fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }

      Widget articleImage() {
        return Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(article.thumbnail), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(defaultRadius)));
      }

      Widget articleText() {
        return Container(
          margin: const EdgeInsets.only(top: 28),
          child: Text(
            article.content,
            style: darkText.copyWith(fontSize: 12),
          ),
        );
      }

      return Expanded(
        child: Container(
          color: white,
          child: ListView(
            padding: EdgeInsets.all(defaultMargin),
            children: [
              headerArticle(),
              const SizedBox(
                height: 12,
              ),
              articleImage(),
              articleText()
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: white2,
      appBar: header(),
      body: Column(
        children: [content()],
      ),
    );
  }
}
