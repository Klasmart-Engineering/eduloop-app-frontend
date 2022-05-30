import 'package:edu_app/components/common/question_progress_indicator.dart';
import 'package:edu_app/providers/riverpod/quiz_data.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizAppBar extends HookConsumerWidget {
  const QuizAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizListener = ref.watch(quizDataProvider);

    if (quizListener is AsyncLoading) {
      return const Text('loading');
    }

    final data = quizListener.value;

    if (data == null) {
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
                currentQuestion: data.quiz.currentQuestionNumber,
                totalQuestions: data.quiz.totalNumberOfQuestions,
              ),
              height: 50,
              width: 50,
            ))),
            OutlinedButton.icon(
                label: Text(data.quiz.earnedScore.toString(),
                    style: const TextStyle(color: Colors.white)),
                icon: const Icon(
                  Icons.star,
                  color: Colors.white,
                ),
                onPressed: () => {},
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontWeight: FontWeight.bold)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36.0),
                    )),
                    side: MaterialStateProperty.all(const BorderSide(
                        color: Colors.white,
                        width: 1.0,
                        style: BorderStyle.solid))))
          ],
        ));
  }
}
