import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/article_tile_user.dart';
import 'package:moodly/widgets/bar_chart.dart';

class HomeUserPage extends StatelessWidget {
  const HomeUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/example/user_profile.png'),
                        fit: BoxFit.cover,
                      )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hi, ',
                          style: darkText.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                        Text(
                          'Budiman',
                          style: primaryColorText.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        )
                      ],
                    ),
                    Text(
                      'How are you today?',
                      style: darkText.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {},
            child: Icon(
              Icons.settings,
              size: 20,
              color: grey,
            ),
          )
        ],
      );
    }

    Widget dailyMood() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Mood',
              style: darkText.copyWith(fontWeight: medium, fontSize: 14),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultRadius),
                color: white,
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Score Today',
                        style: secondaryColorText.copyWith(
                          fontSize: 12,
                          fontWeight: medium,
                        ),
                      ),
                      Text(
                        '10%',
                        style: primaryColorText.copyWith(
                          fontSize: 32,
                          fontWeight: bold,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Your feel look bad',
                              style: darkText.copyWith(
                                fontSize: 14,
                                fontWeight: medium,
                              ),
                            ),
                            Image.asset(
                              'assets/emote_bad.png',
                              width: 32,
                            )
                          ],
                        ),
                        SizedBox(
                          width: 120,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: dark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Find Consultant',
                              style: whiteText.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget weeklyMood() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weekly Mood',
              style: darkText.copyWith(fontWeight: medium, fontSize: 14),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultRadius),
                color: white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BarChart(
                    value: 0.5,
                    time: Timestamp.now(),
                  ),
                  BarChart(
                    value: 0.5,
                    time: Timestamp.now(),
                  ),
                  BarChart(
                    value: 1,
                    time: Timestamp.now(),
                  ),
                  BarChart(
                    value: 0.75,
                    time: Timestamp.now(),
                  ),
                  BarChart(
                    value: 1,
                    time: Timestamp.now(),
                  ),
                  BarChart(
                    value: 0.25,
                    time: Timestamp.now(),
                  ),
                  BarChart(
                    value: 0.5,
                    time: Timestamp.now(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget newArticles() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New Articles',
                  style: darkText.copyWith(fontWeight: medium, fontSize: 14),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/article-user');
                  },
                  child: Text(
                    'More Articles',
                    style: secondaryColorText.copyWith(
                        fontWeight: medium, fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              children: const [
                ArticleTileUser(),
                ArticleTileUser(),
                ArticleTileUser(),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: white2,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(defaultMargin),
          children: [
            header(),
            dailyMood(),
            weeklyMood(),
            newArticles(),
          ],
        ),
      ),
    );
  }
}
