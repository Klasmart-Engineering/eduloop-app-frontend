import 'package:edu_app/models/question_status.dart';
import 'package:edu_app/models/quiz.dart';
import 'package:edu_app/providers/riverpod/quiz_data.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

class QuizCarouselNavigationButtons extends HookConsumerWidget {
  const QuizCarouselNavigationButtons(
      {required this.previousPageTapHandler,
      required this.nextPageTapHandler,
      Key? key})
      : super(key: key);

  final void Function() previousPageTapHandler;
  final void Function() nextPageTapHandler;

  String determineNextButtonText(QuizStateModel? state) {
    if (state != null) {
      if (!state.hasNextQuestion) {
        return "Finish";
      }

      if (state.currentQuestion.status == QuestionStatus.fresh) {
        return "Skip";
      }
    }
    return "Next";
  }

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

    final String nextButtonText = determineNextButtonText(data.quiz);

    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                padding: const EdgeInsets.only(right: 16),
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 25)),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.secondary),
                  ),
                  label: const Text(""),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  onPressed: previousPageTapHandler,
                )),
            Expanded(
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 25)),
                      ),
                      label: Text(nextButtonText,
                          style: const TextStyle(fontSize: 20)),
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                      onPressed: nextPageTapHandler,
                    ))),
          ],
        ));
  }
}
