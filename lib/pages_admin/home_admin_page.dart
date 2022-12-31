import 'package:flutter/material.dart';
import 'package:moodly/pages_admin/add_consultant_page.dart';
import 'package:moodly/pages_admin/detail_article_admin_page.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/feature_admin_tile.dart';

class HomeAdminPage extends StatelessWidget {
  const HomeAdminPage({super.key});

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
                          'Admin',
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

    Widget featureTitle() {
      return Container(
        margin: const EdgeInsets.only(top: 50, bottom: 16),
        child: Text(
          'Features',
          style: darkText.copyWith(fontWeight: semibold, fontSize: 16),
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
            featureTitle(),
            FeatureAdminTile(
              onTap: () {
                Navigator.pushNamed(context, '/chat-list-admin');
              },
              icon: Icons.forum,
              color: primaryColor,
              subtitle: 'Reply',
              title: 'Chats',
              isChat: true,
            ),
            FeatureAdminTile(
              onTap: () {
                Navigator.pushNamed(context, '/tracking-admin');
              },
              icon: Icons.analytics,
              color: grey,
              subtitle: 'Manage',
              title: 'Question Tracking',
            ),
            FeatureAdminTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddConsultantPage()));
              },
              icon: Icons.edit,
              color: secondaryColor,
              subtitle: 'Manage',
              title: 'Articles',
            ),
            FeatureAdminTile(
              onTap: () {
                Navigator.pushNamed(context, '/consultant-admin');
              },
              icon: Icons.group,
              color: dark,
              subtitle: 'Manage',
              title: 'Consultants',
            ),
          ],
        ),
      ),
    );
  }
}
