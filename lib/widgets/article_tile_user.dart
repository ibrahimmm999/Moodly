import 'package:flutter/material.dart';
import 'package:moodly/pages_user/detail_article_user_page.dart';

import '../model/article_model.dart';
import '../service/time_converter.dart';
import '../shared/theme.dart';

class ArticleTileUser extends StatelessWidget {
  const ArticleTileUser({required this.article, super.key});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailArticleUserPage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        width: 315,
        height: 110,
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              height: 102,
              width: 102,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: NetworkImage(article.thumbnail),
                      fit: BoxFit.cover)),
            ),
            Expanded(
              child: Container(
                width: 193,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      article.title,
                      style: primaryColorText.copyWith(
                          fontSize: 13, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      ConvertTime().convertToAgo(article.date),
                      style: secondaryColorText.copyWith(fontSize: 8),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      article.author,
                      style: greyText.copyWith(fontSize: 8),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
