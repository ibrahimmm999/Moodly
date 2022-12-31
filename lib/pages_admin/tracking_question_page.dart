import 'package:flutter/material.dart';
import '../shared/theme.dart';

class TrackingQuestionPage extends StatelessWidget {
  TrackingQuestionPage({super.key});

  final TextEditingController questionController =
      TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return AppBar(
        toolbarHeight: 70,
        backgroundColor: white,
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10, bottom: 3),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home-admin');
              },
              icon: const Icon(
                Icons.check_rounded,
              ),
              iconSize: 24,
              color: secondaryColor,
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: primaryColor,
          iconSize: 16,
        ),
        title: Text(
          'Tracking Question',
          style: primaryColorText.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget inputQuestoin() {
      return TextFormField(
          controller: questionController,
          cursorColor: primaryColor,
          decoration: InputDecoration(
              hintStyle: greyText,
              focusColor: primaryColor,
              border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(defaultRadius)),
                  borderSide: BorderSide(color: dark)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  borderSide: BorderSide(color: primaryColor))));
    }

    Widget questionTile() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "No.1",
              style: darkText.copyWith(fontWeight: medium, fontSize: 12),
            ),
            const SizedBox(
              height: 4,
            ),
            inputQuestoin()
          ],
        ),
      );
    }

    Widget button() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle),
            color: primaryColor,
            iconSize: 32,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove_circle),
            color: dark,
            iconSize: 32,
          )
        ],
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: defaultMargin),
        children: [questionTile(), button()],
      );
    }

    return Scaffold(
      backgroundColor: white2,
      appBar: header(),
      body: content(),
    );
  }
}
