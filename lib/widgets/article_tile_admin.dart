import 'package:flutter/material.dart';
import 'package:moodly/model/article_model.dart';
import 'package:moodly/shared/theme.dart';

import '../pages_admin/detail_article_admin_page.dart';
import '../service/time_converter.dart';

class ArticleTileAdmin extends StatelessWidget {
  const ArticleTileAdmin({required this.article, Key? key}) : super(key: key);
  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailArticleAdminPage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        width: double.infinity,
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
              child: SizedBox(
                width: 193,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      article.title,
                      style: darkText.copyWith(
                          fontSize: 13, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      ConvertTime().convertToAgo(article.date),
                      style: darkText.copyWith(fontSize: 8),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      article.author,
                      style: secondaryColorText.copyWith(fontSize: 8),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: white,
              child: Column(
                children: [
                  Material(
                    color: white,
                    borderRadius: BorderRadius.circular(defaultRadius),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(defaultRadius),
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Center(
                          child: Icon(
                            Icons.edit,
                            color: secondaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: white,
                    borderRadius: BorderRadius.circular(defaultRadius),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(defaultRadius),
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Center(
                          child: Icon(
                            Icons.delete,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
