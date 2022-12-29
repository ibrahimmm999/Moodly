import 'package:flutter/material.dart';
import 'package:moodly/widgets/article_tile_user.dart';

import '../../../shared/theme.dart';

class ArticlesUserPage extends StatelessWidget {
  const ArticlesUserPage({super.key});

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
      return Expanded(
        child: ListView(
          padding: EdgeInsets.only(
              top: 24, left: defaultMargin, right: defaultMargin),
          children: const [
            ArticleTileUser(),
            ArticleTileUser(),
            ArticleTileUser(),
            ArticleTileUser(),
            ArticleTileUser(),
            ArticleTileUser(),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: Column(
        children: [content()],
      ),
    );
  }
}
