import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/auth_cubit.dart';
import 'package:moodly/cubit/chat_admin_page_cubit.dart';
import 'package:moodly/cubit/chat_input_cubit.dart';
import 'package:moodly/cubit/image_file_cubit.dart';
import 'package:moodly/pages_admin/articles_admin_page.dart';
import 'package:moodly/pages_admin/chat_list_admin_page.dart';
import 'package:moodly/pages_admin/consultants_admin_page.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ImageFileCubit()),
        BlocProvider(create: (context) => ChatAdminPageCubit()),
        BlocProvider(create: (context) => ChatInputCubit()),
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashScreen(),
          '/sign-up': (context) => const SignUpPage(),
          '/sign-in': (context) => const SignInPage(),
          '/home-user': (context) => const HomeUserPage(),
          '/article-user': (context) => const ArticlesUserPage(),
          '/tracking': (context) => const TrackingPage(),
          '/consultant-user': (context) => const ConsultantUserPage(),
          '/edit-profile': (context) => EditProfilePage(),
          '/home-admin': (context) => const HomeAdminPage(),
          '/chat-list-admin': (context) => const ChatListAdminPage(),
          '/consultant-admin': (context) => const ConsultantsAdminPage(),
          '/tracking-admin': (context) => TrackingQuestionPage(),
          '/article-admin': (context) => const ArticlesAdminPage(),
        },
      ),
    );
  }
}
