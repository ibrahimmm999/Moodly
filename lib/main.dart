import 'package:flutter/material.dart';
import 'package:moodly/sign_up_page.dart';
import 'package:moodly/splash_screen.dart';

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
        '/sign-up': (context) => const SignUpPage(),
      },
    );
  }
}
