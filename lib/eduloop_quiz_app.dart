import 'package:edu_app/app_config.dart';
import 'package:edu_app/screens/quiz/quiz.dart';
import 'package:edu_app/screens/quiz/results.dart';
import 'package:edu_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/screens/splash.dart';
import 'package:edu_app/screens/introduction.dart';
import 'package:edu_app/screens/user/login.dart';
import 'package:edu_app/screens/user/sign_up.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EduloopQuizApp extends StatelessWidget {
  const EduloopQuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: MaterialApp(
            title: AppConfig.of(context).appTitle,
            theme: CustomTheme.lightTheme,
            initialRoute: '/splash',
            routes: {
          '/introduction': (context) => const IntroductionScreen(),
          '/sign-up': (context) => const SignUpScreen(),
          '/login': (context) => const LoginScreen(),
          '/splash': (context) => const SplashScreen(),
          '/quiz': (context) => const QuizScreen(),
          '/quiz-results': (context) => const QuizResultsScreen()
        }));
  }
}
