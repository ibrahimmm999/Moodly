import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/article_cubit.dart';
import 'package:moodly/pages_admin/detail_article_admin_page.dart';
import 'package:moodly/widgets/article_tile_admin.dart';
import 'package:moodly/widgets/custom_button.dart';

import '../shared/theme.dart';

class ArticlesAdminPage extends StatelessWidget {
  const ArticlesAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi
    ArticleCubit articleCubit = context.read<ArticleCubit>();
    articleCubit.fetchArticles();

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
      return BlocConsumer<ArticleCubit, ArticleState>(
        bloc: articleCubit,
        listener: (context, state) {
          if (state is ArticleFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: primaryColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ArticleSuccess) {
            state.articles.sort(
              (b, a) => a.date.compareTo(b.date),
            );
            return ListView(
              padding: EdgeInsets.only(
                  top: 24, left: defaultMargin, right: defaultMargin),
              children: state.articles
                  .map((e) => ArticleTileAdmin(article: e))
                  .toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator(color: dark));
          }
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
                  builder: (context) => DetailArticleAdminPage(),
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
