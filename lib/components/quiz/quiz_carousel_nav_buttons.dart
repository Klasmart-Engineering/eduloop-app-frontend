import 'package:edu_app/models/question_status.dart';
import 'package:edu_app/models/quiz_state.dart';
import 'package:edu_app/providers/quiz_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    final quizListener = ref.watch(quizManagerProvider);

    if (quizListener is AsyncLoading) {
      return const Text('loading');
    }

    final quiz = quizListener.value;

    if (quiz == null) {
      return const Text('no data');
    }

    final String nextButtonText = determineNextButtonText(quiz.state);

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
