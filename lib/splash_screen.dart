import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/cubit/auth_cubit.dart';
import 'package:moodly/models/user_model.dart';
import 'package:moodly/pages_admin/home_admin_page.dart';
import 'package:moodly/pages_user/home_user_page.dart';
import 'package:moodly/service/user_service.dart';
import 'package:moodly/shared/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      User? currentUser = FirebaseAuth.instance.currentUser;
      final navigator = Navigator.of(context);

      if (currentUser == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/sign-up', (route) => false);
      } else {
        context.read<AuthCubit>().getCurrentUser(currentUser.uid);
        UserModel user = await UserService().getUserbyId(currentUser.uid);
        if (user.role == 'user') {
          navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const HomeUserPage(),
              ),
              (route) => false);
        } else if (user.role == 'admin') {
          navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const HomeAdminPage(),
              ),
              (route) => false);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Image.asset(
          'assets/moodly_logo.png',
          width: 300,
        ),
      ),
    );
  }
}
