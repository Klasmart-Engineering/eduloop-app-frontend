import 'package:edu_app/components/quiz/quiz_app_bar.dart';
import 'package:edu_app/components/quiz/quiz_carousel.dart';
import 'package:edu_app/providers/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatelessWidget {
  static const routeName = 'quiz';

  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => QuizProviderModel(),
        child: Scaffold(
            body: Column(children: const [QuizAppBar(), QuizCarousel()])));
  }
}
