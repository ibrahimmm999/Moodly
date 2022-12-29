import 'package:flutter/material.dart';
import 'package:moodly/widgets/custom_button.dart';

import '../shared/theme.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

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

    Widget choiceButton(String choice) {
      return TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
              backgroundColor: choice == 'Yes' ? primaryColor : dark,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24))),
          child: Text(
            choice,
            style: whiteText.copyWith(fontSize: 12, fontWeight: semibold),
          ));
    }

    Widget trackingQuestion() {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius), color: white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Apakah Keadaan Anda Bagus Hari Ini?",
                style: darkText.copyWith(fontSize: 12, fontWeight: semibold)),
            const SizedBox(
              height: 13,
            ),
            Row(
              children: [
                choiceButton("Yes"),
                const SizedBox(
                  width: 16,
                ),
                choiceButton("No")
              ],
            )
          ],
        ),
      );
    }

    Widget trackingAnswer() {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius), color: white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Apakah Keadaan Anda Bagus Hari Ini?",
                style: darkText.copyWith(fontSize: 12, fontWeight: semibold)),
            const SizedBox(
              height: 13,
            ),
            Text(
              "Answer : Yes",
              style: secondaryColorText.copyWith(
                  fontSize: 12, fontWeight: semibold),
            )
          ],
        ),
      );
    }

    Widget submitButton() {
      return CustomButton(
          radiusButton: defaultRadius,
          buttonColor: primaryColor,
          buttonText: "Submit",
          widthButton: double.infinity,
          onPressed: () {},
          heightButton: 50);
    }

    Widget content() {
      return Container(
        color: white2,
        child: ListView(
          padding: EdgeInsets.only(
              top: 24, left: defaultMargin, right: defaultMargin, bottom: 50),
          children: [
            trackingQuestion(),
            trackingAnswer(),
            trackingQuestion(),
            trackingAnswer(),
            trackingQuestion(),
            trackingAnswer(),
            submitButton()
          ],
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: content(),
    );
  }
}
