import 'package:edu_app/components/quiz/quiz_app_bar.dart';
import 'package:edu_app/components/quiz/quiz_carousel.dart';
import 'package:edu_app/models/question_status.dart';
import 'package:edu_app/models/quiz.dart';
import 'package:edu_app/providers/riverpod/quiz_data.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizScreen extends ConsumerWidget {
  static const routeName = 'quiz';

  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(quizDataProvider).when(
        data: (QuizData quizData) {
          return Scaffold(
              body: Column(children: [
            const QuizAppBar(),
            QuizCarousel(
              initialQuestionNumber: quizData.initialQuestionNumber,
              totalNumberOfQuestions: quizData.quiz.totalNumberOfQuestions,
            )
          ]));
        },
        error: (err, stack) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(
              child: Text('$err'),
            ),
          );
        },
        loading: () => Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()),
            ));
  }
}
