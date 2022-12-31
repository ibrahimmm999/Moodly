import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/article_cubit.dart';
import 'package:moodly/cubit/chat_admin_page_cubit.dart';
import 'package:moodly/cubit/chat_input_cubit.dart';
import 'package:moodly/cubit/image_file_cubit.dart';
import 'package:moodly/pages_admin/articles_admin_page.dart';
import 'package:moodly/pages_admin/chat_list_admin_page.dart';
import 'package:moodly/pages_admin/consultant_admin_page.dart';
import 'package:moodly/pages_admin/home_admin_page.dart';
import 'package:moodly/pages_admin/tracking_question_page.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ImageFileCubit()),
        BlocProvider(create: (context) => ArticleCubit()),
        BlocProvider(create: (context) => ChatAdminPageCubit()),
        BlocProvider(create: (context) => ChatInputCubit()),
      ],
      child: MaterialApp(
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
          '/home-admin': (context) => const HomeAdminPage(),
          '/chat-list-admin': (context) => const ChatListAdminPage(),
          '/consultant-admin': (context) => const ConsultantAdminPage(),
          '/tracking-admin': (context) => TrackingQuestionPage(),
          '/article-admin': (context) => const ArticlesAdminPage(),
        },
      ),
    );
  }
}
