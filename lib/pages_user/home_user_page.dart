import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:moodly/pages_user/help_chat_user_page.dart';
import 'package:moodly/pages_user/support_chat_user_page.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/bar_chart.dart';

class HomeUserPage extends StatelessWidget {
  const HomeUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDailyTracking = false;

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
                        image: AssetImage('assets/profile_default.png'),
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
          PopupMenuButton(
            icon: Icon(
              Icons.settings,
              color: grey,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            elevation: 4,
            onSelected: (value) {
              if (value == 0) {
                Navigator.pushNamed(context, '/edit-profile');
              } else {}
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text(
                  'Edit Profile',
                  style: darkText,
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Text(
                  'Logout',
                  style: primaryColorText,
                ),
              ),
            ],
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
                            onPressed: () {
                              Navigator.pushNamed(context, '/consultant-user');
                            },
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

    Widget dailyMoodEmpty() {
      return GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/tracking'),
        child: Container(
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
                  color: primaryColor,
                ),
                child: Row(
                  children: [
                    Image.asset('assets/mood_tracking.png', width: 128),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Tracking Your Daily',
                            style: whiteText.copyWith(
                              fontSize: 12,
                              fontWeight: medium,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Mood',
                            style: whiteText.copyWith(
                              fontSize: 24,
                              fontWeight: bold,
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
              children: const [],
            ),
          ],
        ),
      );
    }

    Widget floatingButton() {
      return SpeedDial(
        elevation: 4,
        backgroundColor: primaryColor,
        childrenButtonSize: const Size(60, 60),
        spaceBetweenChildren: 16,
        buttonSize: const Size(54, 54),
        activeChild: const Icon(Icons.close),
        children: [
          SpeedDialChild(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SupportChatUserPage()),
              );
            },
            elevation: 4,
            backgroundColor: secondaryColor,
            label: 'Support Messages',
            labelBackgroundColor: white,
            labelStyle: darkText,
            child: Icon(
              Icons.forum_rounded,
              color: white,
            ),
          ),
          SpeedDialChild(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HelpChatUserPage()),
              );
            },
            elevation: 4,
            backgroundColor: secondaryColor,
            label: 'Help Center',
            labelBackgroundColor: white,
            labelStyle: darkText,
            child: Icon(
              Icons.contact_support_rounded,
              color: white,
            ),
          )
        ],
        child: Image.asset(
          'assets/icon_chat_floating.png',
          width: 30,
        ),
      );
    }

    return Scaffold(
      backgroundColor: white2,
      floatingActionButton: floatingButton(),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(defaultMargin),
          children: [
            header(),
            // ignore: dead_code
            !isDailyTracking ? dailyMood() : dailyMoodEmpty(),
            weeklyMood(),
            newArticles(),
          ],
        ),
      ),
    );
  }
}
