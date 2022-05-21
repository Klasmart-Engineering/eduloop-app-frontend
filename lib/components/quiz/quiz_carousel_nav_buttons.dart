import 'package:edu_app/models/question_status.dart';
import 'package:edu_app/models/quiz.dart';
import 'package:edu_app/providers/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizCarouselNavigationButtons extends StatelessWidget {
  const QuizCarouselNavigationButtons(
      {required this.previousPageTapHandler,
      required this.nextPageTapHandler,
      Key? key})
      : super(key: key);

  final void Function() previousPageTapHandler;
  final void Function() nextPageTapHandler;

  String determineNextButtonText(QuizStateModel? state) {
    if (state != null) {
      if (state.currentQuestionNumber == state.totalNumberOfQuestions) {
        return "Finish";
      }

      if (state.currentQuestion.status == QuestionStatus.fresh) {
        return "Skip";
      }
    }
    return "Next";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProviderModel>(builder: (context, quiz, child) {
      String nextButtonText = determineNextButtonText(quiz.state);

      return Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary),
                ),
                label: const Text(""),
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                onPressed: previousPageTapHandler,
              ),
              ElevatedButton.icon(
                label: Text(nextButtonText),
                icon: const Icon(
                  Icons.arrow_forward,
                ),
                onPressed: nextPageTapHandler,
              )
            ],
          ));
    });
  }
}
