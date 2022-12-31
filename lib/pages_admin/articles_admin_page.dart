import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/article_cubit.dart';
import 'package:moodly/pages_admin/detail_article_admin_page.dart';
import 'package:moodly/widgets/article_tile_admin.dart';
import 'package:moodly/widgets/custom_button.dart';

import '../models/article_model.dart';
import '../shared/theme.dart';

class ArticlesAdminPage extends StatefulWidget {
  const ArticlesAdminPage({super.key});

  @override
  State<ArticlesAdminPage> createState() => _ArticlesAdminPageState();
}

class _ArticlesAdminPageState extends State<ArticlesAdminPage> {
  @override
  void initState() {
    context.read<ArticleCubit>().fetchArticles();
    super.initState();
  }

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

    Widget articleList(List<ArticleModel> articles) {
      articles.sort(
        (a, b) => a.date.compareTo(b.date),
      );
      return ListView(
          padding: EdgeInsets.only(
              top: 24, left: defaultMargin, right: defaultMargin),
          children: articles.map((e) => ArticleTileAdmin(article: e)).toList());
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

    return BlocConsumer<ArticleCubit, ArticleState>(
      listener: (context, state) {
        if (state is ArticleFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            backgroundColor: primaryColor,
          ));
        }
      },
      builder: (context, state) {
        if (state is ArticleSuccess) {
          return Scaffold(
            appBar: header(),
            body: articleList(state.articles),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
