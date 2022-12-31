import 'package:flutter/material.dart';

import '../shared/theme.dart';
import '../widgets/form_consultant_article.dart';

class AddConsultantPage extends StatelessWidget {
  AddConsultantPage({super.key});
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController addressController =
      TextEditingController(text: '');
  final TextEditingController phoneController = TextEditingController(text: '');
  final TextEditingController openTimeController =
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
          'Add Consultant',
          style: primaryColorText.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget content() {
      Widget banner() {
        return Container(
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 70),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultRadius),
              image: const DecorationImage(
                  image: AssetImage("assets/example/profile_pict_example.png"),
                  fit: BoxFit.cover)),
        );
      }

      Widget inputName() {
        return FormConsultantAndArticle(
            controller: nameController, minlines: 1, title: 'Name');
      }

      Widget inputOpenTime() {
        return FormConsultantAndArticle(
            controller: openTimeController, minlines: 1, title: 'Open Time');
      }

      Widget inputAddress() {
        return FormConsultantAndArticle(
            controller: addressController, minlines: 1, title: 'Address');
      }

      Widget inputPhone() {
        return FormConsultantAndArticle(
            controller: phoneController, minlines: 1, title: 'Phone');
      }

      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 24),
        children: [
          banner(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 140, vertical: 12),
            child: Material(
              color: dark,
              borderRadius: BorderRadius.circular(defaultRadius),
              child: InkWell(
                borderRadius: BorderRadius.circular(defaultRadius),
                onTap: () {},
                child: SizedBox(
                  width: 42,
                  height: 26,
                  child: Icon(Icons.edit, color: white, size: 20),
                ),
              ),
            ),
          ),
          Text('Name', style: darkText.copyWith(fontSize: 12)),
          const SizedBox(height: 10),
          inputName(),
          const SizedBox(
            height: 20,
          ),
          Text('Phone', style: darkText.copyWith(fontSize: 12)),
          const SizedBox(height: 10),
          inputPhone(),
          const SizedBox(height: 20),
          Text(
            'Open Time',
            style: darkText.copyWith(
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          inputOpenTime(),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Address',
            style: darkText.copyWith(
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          inputAddress(),
          const SizedBox(
            height: 20,
          )
        ],
      );
    }

    return Scaffold(
      appBar: header(),
      body: content(),
    );
  }
}
