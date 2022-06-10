import 'package:edu_app/components/quiz/quiz_app_bar.dart';
import 'package:edu_app/components/quiz/quiz_carousel.dart';
import 'package:edu_app/providers/quiz_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizScreen extends ConsumerWidget {
  static const routeName = 'quiz';

  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<QuizManager> _quizManager = ref.watch(quizManagerProvider);

    return Scaffold(
        body: _quizManager.when(
            data: (QuizManager quizManager) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const QuizAppBar(),
                    Expanded(
                        child: QuizCarousel(
                      initialQuestionNumber: quizManager.initialQuestionNumber,
                      totalNumberOfQuestions:
                          quizManager.state.totalNumberOfQuestions,
                    )),
                  ]);
            },
            error: (err, stack) => Center(child: Text('$err')),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
