import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/article_save_cubit.dart';
import 'package:moodly/cubit/auth_cubit.dart';
import 'package:moodly/cubit/change_location_cubit.dart';
import 'package:moodly/cubit/chat_admin_page_cubit.dart';
import 'package:moodly/cubit/chat_input_cubit.dart';
import 'package:moodly/cubit/consultant_save_cubit.dart';
import 'package:moodly/cubit/image_file_cubit.dart';
import 'package:moodly/cubit/image_url_cubit.dart';
import 'package:moodly/cubit/obscure_form_cubit.dart';
import 'package:moodly/cubit/question_form_cubit.dart';
import 'package:moodly/cubit/send_chat_cubit.dart';
import 'package:moodly/cubit/status_help_cubit.dart';
import 'package:moodly/cubit/tracking_cubit.dart';
import 'package:moodly/cubit/user_update_cubit.dart';
import 'package:moodly/pages_admin/articles_admin_page.dart';
import 'package:moodly/pages_admin/chat_list_admin_page.dart';
import 'package:moodly/pages_admin/consultants_admin_page.dart';
import 'package:moodly/pages_admin/home_admin_page.dart';
import 'package:moodly/pages_admin/tracking_question_page.dart';
import 'package:moodly/pages_user/articles_user_page.dart';
import 'package:moodly/pages_user/consultant_user_page.dart';
import 'package:moodly/pages_user/home_user_page.dart';
import 'package:moodly/pages_user/tracking_page.dart';

import 'cubit/answer_tracking_cubit.dart';
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
        BlocProvider(create: (context) => ImageUrlCubit()),
        BlocProvider(create: (context) => ChatAdminPageCubit()),
        BlocProvider(create: (context) => ChatInputCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ArticleSaveCubit()),
        BlocProvider(create: (context) => ConsultantSaveCubit()),
        BlocProvider(create: (context) => UserUpdateCubit()),
        BlocProvider(create: (context) => SendChatCubit()),
        BlocProvider(create: (context) => StatusHelpCubit()),
        BlocProvider(create: (context) => ChangeLocationCubit()),
        BlocProvider(create: (context) => QuestionFormCubit()),
        BlocProvider(create: (context) => TrackingCubit()),
        BlocProvider(create: (context) => AnswerTrackingCubit()),
        BlocProvider(create: (context) => ObscureFormCubit()),
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
          '/home-admin': (context) => const HomeAdminPage(),
          '/chat-list-admin': (context) => const ChatListAdminPage(),
          '/consultant-admin': (context) => const ConsultantsAdminPage(),
          '/tracking-admin': (context) => const TrackingQuestionPage(),
          '/article-admin': (context) => const ArticlesAdminPage(),
        },
      ),
    );
  }
}
