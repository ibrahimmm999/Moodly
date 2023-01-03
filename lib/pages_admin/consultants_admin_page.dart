import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moodly/models/consultant_model.dart';
import 'package:moodly/pages_admin/detail_consultant_admin_page.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/custom_button.dart';

class ConsultantsAdminPage extends StatelessWidget {
  const ConsultantsAdminPage({super.key});

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
          'Consultant',
          style: primaryColorText.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget consultantTileAdmin(ConsultantModel consultant) {
      return Container(
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          color: white,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(defaultRadius),
              child: Image.network(
                consultant.photoUrl,
                width: 102,
                height: 102,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    consultant.name,
                    style: darkText.copyWith(
                      fontSize: 16,
                      fontWeight: semibold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    consultant.openTime,
                    style: const TextStyle(
                      color: Color(0xFF6BCBB8),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: secondaryColor,
                        size: 20,
                      ),
                      Text(
                        consultant.phone,
                        style: darkText.copyWith(fontSize: 12),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    consultant.address,
                    style: darkText.copyWith(
                      fontSize: 10,
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Material(
                  color: white,
                  borderRadius: BorderRadius.circular(defaultRadius),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailConsultantAdminPage(
                            id: consultant.id,
                            name: consultant.name,
                            photoUrl: consultant.photoUrl,
                            phone: consultant.phone,
                            openTime: consultant.openTime,
                            address: consultant.address,
                            province: consultant.province,
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
            )
          ],
        ),
      );
    }

    Widget consultantList() {
      return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
            FirebaseFirestore.instance.collection('consultants').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var consultans = snapshot.data!.docs.map((e) {
              return ConsultantModel.fromJson(e.id, e.data());
            }).toList();
            consultans.sort(
              (a, b) => a.name.compareTo(b.name),
            );
            return ListView(
              padding: EdgeInsets.only(
                top: 24,
                left: defaultMargin,
                right: defaultMargin,
              ),
              children: consultans.map(
                (e) {
                  return consultantTileAdmin(e);
                },
              ).toList(),
            );
          }
          return Center(
            child: LoadingAnimationWidget.twistingDots(
              leftDotColor: secondaryColor,
              rightDotColor: primaryColor,
              size: 60,
            ),
          );
        },
      );
    }

    Widget addArticleButton() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 16),
        child: CustomButton(
            radiusButton: defaultRadius,
            buttonColor: primaryColor,
            buttonText: "Add Consultant",
            widthButton: double.infinity,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailConsultantAdminPage(),
                ),
              );
            },
            heightButton: 50),
      );
    }

    return Scaffold(
      backgroundColor: white2,
      appBar: header(),
      body: Column(
        children: [
          Expanded(
            child: consultantList(),
          ),
          addArticleButton(),
        ],
      ),
    );
  }
}
