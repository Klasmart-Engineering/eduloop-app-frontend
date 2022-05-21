// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:edu_app/screens/quiz/quiz.dart';
import 'package:edu_app/screens/quiz/results.dart';
import 'package:edu_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/screens/splash.dart';
import 'package:edu_app/screens/introduction.dart';
import 'package:edu_app/screens/user/login.dart';
import 'package:edu_app/screens/user/sign_up.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  //await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome to Flutter',
        theme: CustomTheme.lightTheme,
        initialRoute: '/splash',
        routes: {
          '/introduction': (context) => const IntroductionScreen(),
          '/sign-up': (context) => const SignUpScreen(),
          '/login': (context) => const LoginScreen(),
          '/splash': (context) => const SplashScreen(),
          '/quiz': (context) => QuizScreen(),
          '/quiz-results': (context) => const QuizResultsScreen()
        });
  }
}
