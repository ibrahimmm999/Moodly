import 'package:flutter/material.dart';

import '../shared/theme.dart';

class DetailArticleAdminPage extends StatelessWidget {
  const DetailArticleAdminPage({super.key});

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
          'Write Article',
          style: primaryColorText.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    return Scaffold(
      appBar: header(),
    );
  }
}
