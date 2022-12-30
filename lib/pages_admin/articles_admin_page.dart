import 'package:flutter/material.dart';
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

    Widget addArticleButton() {
      return CustomButton(
          radiusButton: defaultRadius,
          buttonColor: primaryColor,
          buttonText: "Add Article",
          widthButton: double.infinity,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DetailArticleAdminPage()));
          },
          heightButton: 50);
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: defaultMargin),
        children: [
          const ArticleTileAdmin(),
          const ArticleTileAdmin(),
          const ArticleTileAdmin(),
          const ArticleTileAdmin(),
          addArticleButton()
        ],
      );
    }

    return Scaffold(
      appBar: header(),
      body: content(),
    );
  }
}
