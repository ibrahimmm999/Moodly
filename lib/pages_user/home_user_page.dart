import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moodly/cubit/auth_cubit.dart';
import 'package:moodly/models/article_model.dart';
import 'package:moodly/models/mood_data.dart';
import 'package:moodly/models/user_model.dart';
import 'package:moodly/pages_user/chat_user_page.dart';
import 'package:moodly/pages_user/edit_profile_page.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/article_tile_user.dart';
import 'package:moodly/widgets/bar_chart.dart';

class HomeUserPage extends StatelessWidget {
  const HomeUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    AuthCubit authCubit = context.read<AuthCubit>();

    Widget header() {
      return BlocBuilder<AuthCubit, AuthState>(
        bloc: authCubit,
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: state.user.photoUrl.isEmpty
                              ? const DecorationImage(
                                  image:
                                      AssetImage('assets/profile_default.png'),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: NetworkImage(state.user.photoUrl),
                                  fit: BoxFit.cover,
                                ),
                        ),
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
                                state.user.name,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(
                            id: state.user.id,
                            name: state.user.name,
                            photoUrl: state.user.photoUrl,
                            username: state.user.username,
                          ),
                        ),
                      );
                    } else {
                      Navigator.pushNamed(context, '/sign-in');
                    }
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
                      onTap: () {
                        authCubit.signOut();
                      },
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
          return Center(
            child: CircularProgressIndicator(color: dark),
          );
        },
      );
    }

    Widget dailyMoodEmpty() {
      return GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/tracking'),
        child: Container(
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
        ),
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
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  bool isDailyTracking;
                  MoodDataModel moodLast;
                  var moodList = UserModel.fromJson(
                          snapshot.data!.data() as Map<String, dynamic>)
                      .moodDataList;

                  if (moodList.isNotEmpty) {
                    isDailyTracking = DateFormat('dd-MM-yyyy')
                            .format(moodList.last.date.toDate()) ==
                        DateFormat('dd-MM-yyyy').format(DateTime.now());
                  } else {
                    isDailyTracking = false;
                  }

                  if (isDailyTracking) {
                    moodLast = moodList.last;
                    return Container(
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
                                '${moodLast.score.round()}%',
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
                                      moodLast.score < 25
                                          ? 'Your feel look bad'
                                          : moodLast.score < 50
                                              ? 'Your feel look not bad'
                                              : moodLast.score < 75
                                                  ? 'Your feel look good'
                                                  : 'Your feel look happy',
                                      style: darkText.copyWith(
                                        fontSize: 14,
                                        fontWeight: medium,
                                      ),
                                    ),
                                    Image.asset(
                                      moodLast.score < 25
                                          ? 'assets/emote_bad.png'
                                          : moodLast.score < 50
                                              ? 'assets/emote_not_bad.png'
                                              : moodLast.score < 75
                                                  ? 'assets/emote_good.png'
                                                  : 'assets/emote_happy.png',
                                      width: 32,
                                    )
                                  ],
                                ),
                                moodLast.score < 25
                                    ? SizedBox(
                                        width: 120,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ChatUserPage(
                                                        isSupportChat: false),
                                              ),
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: Text(
                                            'Go to help center',
                                            style: whiteText.copyWith(
                                              fontSize: 12,
                                              fontWeight: medium,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return dailyMoodEmpty();
                  }
                }
                return Center(
                  child: LoadingAnimationWidget.twistingDots(
                    leftDotColor: secondaryColor,
                    rightDotColor: primaryColor,
                    size: 24,
                  ),
                );
              },
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
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var moodList = UserModel.fromJson(
                          snapshot.data!.data() as Map<String, dynamic>)
                      .moodDataList;

                  List<MoodDataModel> weekly = [];
                  var date = DateTime.now();
                  date = DateTime(date.year, date.month, date.day);
                  for (var i = 0; i < 7; i++) {
                    var contain = moodList.where(
                      (element) {
                        var elmtDate = element.date.toDate();
                        return DateTime(
                                elmtDate.year, elmtDate.month, elmtDate.day) ==
                            date;
                      },
                    );

                    if (contain.isNotEmpty) {
                      weekly.add(contain.first);
                    } else {
                      weekly.add(MoodDataModel(
                          date: Timestamp.fromDate(date), score: 0));
                    }

                    var before = DateTime(date.year, date.month, date.day - 1);
                    date = before;
                  }

                  return Container(
                    padding: const EdgeInsets.all(24),
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultRadius),
                      color: white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: weekly
                          .map((e) => BarChart(
                                value: e.score / 100,
                                time: e.date,
                              ))
                          .toList()
                          .reversed
                          .toList(),
                    ),
                  );
                }

                return Center(
                  child: LoadingAnimationWidget.twistingDots(
                    leftDotColor: secondaryColor,
                    rightDotColor: primaryColor,
                    size: 24,
                  ),
                );
              },
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
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  FirebaseFirestore.instance.collection('articles').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var articles = snapshot.data!.docs.map((e) {
                    return ArticleModel.fromJson(e.id, e.data());
                  }).toList();
                  articles.sort(
                    (b, a) => a.date.compareTo(b.date),
                  );
                  if (articles.length > 5) {
                    articles.getRange(0, 4);
                  }
                  return Column(
                    children: articles.map(
                      (e) {
                        return ArticleTileUser(
                          article: e,
                        );
                      },
                    ).toList(),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: dark,
                  ),
                );
              },
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
                    builder: (context) =>
                        const ChatUserPage(isSupportChat: true)),
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
                    builder: (context) =>
                        const ChatUserPage(isSupportChat: false)),
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
            dailyMood(),
            weeklyMood(),
            newArticles(),
          ],
        ),
      ),
    );
  }
}
