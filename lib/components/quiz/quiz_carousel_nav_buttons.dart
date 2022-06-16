import 'package:edu_app/components/common/themed_button.dart';
import 'package:edu_app/models/question_status.dart';
import 'package:edu_app/models/quiz_state.dart';
import 'package:edu_app/providers/session_provider.dart';
import 'package:edu_app/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizCarouselNavigationButtons extends HookConsumerWidget {
  const QuizCarouselNavigationButtons(
      {required this.previousPageTapHandler,
      required this.nextPageTapHandler,
      required this.enableButtons,
      Key? key})
      : super(key: key);

  final void Function() previousPageTapHandler;
  final void Function() nextPageTapHandler;
  final bool enableButtons;

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
    final quizSessionListener = ref.watch(quizSessionProvider);

    if (quizSessionListener is AsyncLoading) {
      return const Text('loading');
    }

    final quizSession = quizSessionListener.value;

    if (quizSession == null) {
      return const Text('no data');
    }

    final String nextButtonText = determineNextButtonText(quizSession.quiz);

    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton.icon(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 25)),
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(SizeConstants.elevatedButtonRadius),
                        topRight:
                            Radius.circular(SizeConstants.elevatedButtonRadius),
                        bottomLeft:
                            Radius.circular(SizeConstants.elevatedButtonRadius),
                        bottomRight: Radius.zero),
                  ))),
              label: const Text(""),
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              onPressed: enableButtons ? previousPageTapHandler : null,
            ),
            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 25)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.circular(18)),
                )),
              ),
              child: Text(nextButtonText, style: const TextStyle(fontSize: 20)),
              onPressed: enableButtons ? nextPageTapHandler : null,
            ),
          ],
        ));
  }
}
