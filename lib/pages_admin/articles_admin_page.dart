import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moodly/models/article_model.dart';
import 'package:moodly/pages_admin/detail_article_admin_page.dart';
import 'package:moodly/widgets/article_tile_admin.dart';
import 'package:moodly/widgets/custom_button.dart';

import '../shared/theme.dart';

class ArticlesAdminPage extends StatelessWidget {
  const ArticlesAdminPage({super.key});

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

    Widget articleList() {
      return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('articles').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var articles = snapshot.data!.docs.map((e) {
              return ArticleModel.fromJson(e.id, e.data());
            }).toList();
            articles.sort(
              (b, a) => a.date.compareTo(b.date),
            );
            return ListView(
              padding: EdgeInsets.only(
                top: 24,
                left: defaultMargin,
                right: defaultMargin,
              ),
              children: articles.map(
                (e) {
                  return ArticleTileAdmin(
                    article: e,
                  );
                },
              ).toList(),
            );
          }
          return Center(
            child: LoadingAnimationWidget.twistingDots(
              leftDotColor: secondaryColor,
              rightDotColor: primaryColor,
              size: 60,
            ),
          );
        },
      );
    }

    Widget addArticleButton() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 16),
        child: CustomButton(
            radiusButton: defaultRadius,
            buttonColor: primaryColor,
            buttonText: "Add Article",
            widthButton: double.infinity,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailArticleAdminPage(),
                ),
              );
            },
            heightButton: 50),
      );
    }

    return Scaffold(
      appBar: header(),
      body: Column(
        children: [
          Expanded(
            child: articleList(),
          ),
          addArticleButton(),
        ],
      ),
    );
  }
}
