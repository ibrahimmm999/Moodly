import 'package:flutter/material.dart';
import 'package:moodly/widgets/article_tile_admin.dart';

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

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: defaultMargin),
        children: const [ArticleTileAdmin(), ArticleTileAdmin()],
      );
    }

    return Scaffold(
      appBar: header(),
      body: content(),
    );
  }
}
