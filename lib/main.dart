// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:edu_app/screens/quiz/quiz.dart';
import 'package:edu_app/screens/quiz/results.dart';
import 'package:edu_app/screens/quiz/mock_results_screen.dart';
import 'package:edu_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/screens/splash.dart';
import 'package:edu_app/screens/introduction.dart';
import 'package:edu_app/screens/user/login.dart';
import 'package:edu_app/screens/user/sign_up.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future main() async {
  //await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
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
          '/mock-screen': (context) => const MockQuizResultsScreen(),
          '/sign-up': (context) => const SignUpScreen(),
          '/login': (context) => const LoginScreen(),
          '/splash': (context) => const SplashScreen(),
          '/quiz': (context) => const QuizScreen(),
          '/quiz-results': (context) => const QuizResultsScreen()
        });
  }
}
