import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/auth_cubit.dart';
import 'package:moodly/pages_user/edit_profile_page.dart';
import 'package:moodly/shared/theme.dart';
import 'package:moodly/widgets/feature_admin_tile.dart';

class HomeAdminPage extends StatelessWidget {
  const HomeAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                                image: AssetImage('assets/profile_default.png'),
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
                )),
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
                Navigator.pushNamed(context, '/article-admin');
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
