import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/article_tile_user.dart';
import '../../shared/theme.dart';
import '../cubit/article_cubit.dart';
import '../models/article_model.dart';

class ArticlesUserPage extends StatefulWidget {
  const ArticlesUserPage({super.key});

  @override
  State<ArticlesUserPage> createState() => _ArticlesUserPageState();
}

class _ArticlesUserPageState extends State<ArticlesUserPage> {
  @override
  void initState() {
    context.read<ArticleCubit>().fetchArticles();
    super.initState();
  }

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
          color: secondaryColor,
          iconSize: 16,
        ),
        title: Text(
          'Articles',
          style: secondaryColorText.copyWith(
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
              return ArticleTileUser(
                article: e,
              );
            },
          ).toList());
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
