import 'package:edu_app/components/common/question_progress_indicator.dart';
import 'package:edu_app/components/common/question_score_label.dart';
import 'package:edu_app/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizAppBar extends HookConsumerWidget {
  const QuizAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizSessionListener = ref.watch(quizSessionProvider);

    if (quizSessionListener is AsyncLoading) {
      return const Text('loading');
    }

    final quizSession = quizSessionListener.value;

    if (quizSession == null) {
      return const Text('no data');
    }

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 100),
            Flexible(
                child: Center(
                    child: SizedBox(
              child: QuestionProgressIndicator(
                currentQuestion: quizSession.quiz.currentQuestionNumber,
                totalQuestions: quizSession.quiz.totalNumberOfQuestions,
              ),
              height: 50,
              width: 50,
            ))),
            QuestionScoreLabel(score: quizSession.quiz.earnedScore)
          ],
        ));
  }
}
