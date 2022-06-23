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
    final Radius buttonRadius =
        Radius.circular(SizeConstants.elevatedButtonRadius);

    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            ThemedButton.icon(
                variant: ButtonVariant.secondary,
                onPressed: previousPageTapHandler,
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                isActive: enableButtons,
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: buttonRadius,
                      topRight: buttonRadius,
                      bottomLeft: buttonRadius,
                      bottomRight: Radius.zero),
                )))),
            ThemedButton(
              onPressed: nextPageTapHandler,
              isActive: enableButtons,
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                topLeft: buttonRadius,
                topRight: buttonRadius,
                bottomLeft: Radius.zero,
                bottomRight: buttonRadius,
              )))),
              label: Text(nextButtonText),
            ),
          ],
        ));
  }
}
