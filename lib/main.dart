import 'package:flutter/material.dart';

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
      },
    );
  }
}
