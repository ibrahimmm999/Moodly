import 'package:flutter/material.dart';
import 'package:moodly/pages_user/articles_user_page.dart';
import 'package:moodly/pages_user/consultant_user_page.dart';
import 'package:moodly/pages_user/edit_profile_page.dart';
import 'package:moodly/pages_user/home_user_page.dart';
import 'package:moodly/pages_user/tracking_page.dart';

import 'sign_up_page.dart';
import 'splash_screen.dart';
import 'sign_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        '/sign-up': (context) => SignUpPage(),
        '/sign-in': (context) => SignInPage(),
        '/home-user': (context) => const HomeUserPage(),
        '/article-user': (context) => const ArticlesUserPage(),
        '/tracking': (context) => const TrackingPage(),
        '/consultant-user': (context) => const ConsultantUserPage(),
        '/edit-profile': (context) => EditProfilePage(),
      },
    );
  }
}
