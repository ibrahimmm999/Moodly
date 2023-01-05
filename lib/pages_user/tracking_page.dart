import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moodly/cubit/answer_tracking_cubit.dart';
import 'package:moodly/cubit/tracking_cubit.dart';
import 'package:moodly/models/mood_data.dart';
import 'package:moodly/widgets/custom_button.dart';
import '../shared/theme.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});
  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    TrackingCubit trackingCubit = context.read<TrackingCubit>();

    context.read<AnswerTrackingCubit>().init();

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
          'Tracking',
          style: primaryColorText.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget trackingList() {
      Widget choiceButton(int index) {
        Widget yesButton() {
          return TextButton(
              onPressed: () {
                context.read<AnswerTrackingCubit>().selectAnswer("Yes", index);
              },
              style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24))),
              child: Text(
                "Yes",
                style: whiteText.copyWith(fontSize: 12, fontWeight: semibold),
              ));
        }

        Widget noButton() {
          return TextButton(
              onPressed: () {
                context.read<AnswerTrackingCubit>().selectAnswer("No", index);
              },
              style: TextButton.styleFrom(
                  backgroundColor: dark,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24))),
              child: Text(
                "No",
                style: whiteText.copyWith(fontSize: 12, fontWeight: semibold),
              ));
        }

        return Row(
          children: [
            yesButton(),
            const SizedBox(
              width: 16,
            ),
            noButton()
          ],
        );
      }

      Widget trackingTile(String question, int index) {
        return BlocBuilder<AnswerTrackingCubit, List<String>>(
          builder: (context, state) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  color: white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question,
                      style: darkText.copyWith(
                          fontSize: 12, fontWeight: semibold)),
                  const SizedBox(
                    height: 13,
                  ),
                  choiceButton(index),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Answer : ${state[index]}",
                    style: secondaryColorText.copyWith(
                        fontSize: 12, fontWeight: semibold),
                  )
                ],
              ),
            );
          },
        );
      }

      Widget submitButton() {
        return BlocConsumer<TrackingCubit, TrackingState>(
          bloc: trackingCubit,
          listener: (context, state) {
            if (state is TrackingSuccess) {
              Navigator.pop(context);
            } else if (state is TrackingFailed) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: primaryColor,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is TrackingLoading) {
              return Center(
                child: LoadingAnimationWidget.twistingDots(
                  leftDotColor: secondaryColor,
                  rightDotColor: primaryColor,
                  size: 24,
                ),
              );
            }
            return CustomButton(
                radiusButton: defaultRadius,
                buttonColor: primaryColor,
                buttonText: "Submit",
                widthButton: double.infinity,
                onPressed: () {
                  double score = 0;
                  for (var element
                      in context.read<AnswerTrackingCubit>().state) {
                    element == "Yes" ? score++ : score += 0;
                  }
                  score =
                      score / context.read<AnswerTrackingCubit>().state.length;
                  score *= 100;
                  MoodDataModel mood =
                      MoodDataModel(date: Timestamp.now(), score: score);
                  trackingCubit.submitAnswer(userId, mood);
                },
                heightButton: 50);
          },
        );
      }

      return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('tracking')
              .doc('questions')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var question = (snapshot.data!.data()
                  as Map<String, dynamic>)['listQuestion'] as List;
              for (int i = 0; i < question.length; i++) {
                context.read<AnswerTrackingCubit>().selectAnswer(" ", i);
              }
              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: question.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      trackingTile(question[index], index),
                      index + 1 == question.length
                          ? submitButton()
                          : const SizedBox()
                    ],
                  );
                },
              );
            }
            return Center(
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: secondaryColor,
                rightDotColor: primaryColor,
                size: 60,
              ),
            );
          });
    }

    return Scaffold(
      appBar: header(),
      body: trackingList(),
    );
  }
}
