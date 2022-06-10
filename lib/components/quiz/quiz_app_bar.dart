import 'package:edu_app/components/common/question_progress_indicator.dart';
import 'package:edu_app/providers/quiz_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizAppBar extends HookConsumerWidget {
  const QuizAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizListener = ref.watch(quizManagerProvider);

    if (quizListener is AsyncLoading) {
      return const Text('loading');
    }

    final quiz = quizListener.value;

    if (quiz == null) {
      return const Text('no data');
    }

    return Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 100),
            Flexible(
                child: Center(
                    child: SizedBox(
              child: QuestionProgressIndicator(
                currentQuestion: quiz.state.currentQuestionNumber,
                totalQuestions: quiz.state.totalNumberOfQuestions,
              ),
              height: 50,
              width: 50,
            ))),
            OutlinedButton.icon(
                label: Text(quiz.state.earnedScore.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 20)),
                icon: const Icon(
                  Icons.star,
                  color: Color(0xFFFFD335),
                ),
                onPressed: () => {},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontWeight: FontWeight.bold)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36.0),
                    ))))
          ],
        ));
  }
}
