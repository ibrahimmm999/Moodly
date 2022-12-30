import 'package:flutter/material.dart';
import 'package:moodly/shared/theme.dart';

import '../pages_admin/detail_article_admin_page.dart';

class ArticleTileAdmin extends StatelessWidget {
  const ArticleTileAdmin({
    Key? key,
  }) : super(key: key);

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
                  image: const DecorationImage(
                      image: AssetImage("assets/example/article1_example.png"),
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
                      "Kesehatan Mental : Gejala, Faktor, dan Penanganan",
                      style: darkText.copyWith(
                          fontSize: 13, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "19 September 2022",
                      style: darkText.copyWith(fontSize: 8),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Yuni Rahmawati",
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
