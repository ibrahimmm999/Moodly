import 'package:flutter/material.dart';
import 'package:moodly/models/article_model.dart';
import 'package:moodly/pages_user/detail_article_user_page.dart';
import 'package:moodly/service/article_service.dart';
import 'package:moodly/service/image_service.dart';
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
            builder: (context) => DetailArticleUserPage(
              article: article,
            ),
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
                          fontSize: 12, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      ConvertTime().convertToAgo(article.date),
                      style: secondaryColorText.copyWith(fontSize: 10),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      article.author,
                      style: primaryColorText.copyWith(fontSize: 10),
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailArticleAdminPage(
                              id: article.id,
                              author: article.author,
                              title: article.title,
                              text: article.content,
                              thumbnail: article.thumbnail,
                            ),
                          ),
                        );
                      },
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
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Confirm', style: primaryColorText),
                              content: Text(
                                'Delete this article?',
                                style: darkText,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'NO',
                                    style: darkText,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ArticleService().deleteArticle(article);
                                    ImageTool().deleteImage(article.thumbnail);
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text(
                                    'YES',
                                    style: darkText,
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
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
