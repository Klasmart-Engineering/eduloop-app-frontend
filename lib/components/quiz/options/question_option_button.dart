import 'package:edu_app/components/common/themed_button.dart';
import 'package:edu_app/models/question.dart';
import 'package:flutter/material.dart';

import 'well_done_popup.dart';

class QuestionOptionButton extends StatelessWidget {
  const QuestionOptionButton(
      {Key? key,
      required this.onPressed,
      required this.answerOption,
      this.chosenAnswerIndex})
      : super(key: key);

  final void Function(AnswerModel answerOption)? onPressed;
  final int? chosenAnswerIndex;
  final AnswerModel answerOption;

  /// Once the button has been pressed, set up styles to display correct and wrong answer
  ButtonStyle displayCorrectAnswer(
      bool answerHasBeenSelected, bool isCorrect, bool beenPressed) {
    if (answerHasBeenSelected) {
      if (beenPressed) {
        return ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(isCorrect ? Colors.green : Colors.red),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        );
      }

      if (isCorrect) {
        return ButtonStyle(
            shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: const BorderSide(width: 3, color: Colors.green)),
        ));
      }
    }
    return const ButtonStyle();
  }

  @override
  Widget build(BuildContext context) {
    bool answerHasBeenChosen = chosenAnswerIndex != null;
    bool chosenAnswer = chosenAnswerIndex == answerOption.answerIndex;
    bool stayVisiblyActive = chosenAnswer || answerOption.isCorrect;

    ButtonStyle baseStyle = ButtonStyle(
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 5, horizontal: 10)));
    ButtonStyle colourStyle = displayCorrectAnswer(
        answerHasBeenChosen, answerOption.isCorrect, chosenAnswer);

    /// We still want the right answer and chosen answer to stay visible state, so we provide a hollow function to them
    Function() clickHandler = answerHasBeenChosen
        ? () {}
        : () {
            onPressed!(answerOption);
          };

    return Stack(
        fit: StackFit.expand,
        alignment: Alignment.topCenter,
        children: [
          ThemedButton(
            variant: ButtonVariant.tertiary,
            label: Center(
                child: Text(
              answerOption.label,
              textAlign: TextAlign.center,
              style: TextStyle(overflow: TextOverflow.visible),
            )),
            onPressed: clickHandler,
            style: baseStyle.merge(colourStyle),
            isActive: !answerHasBeenChosen || stayVisiblyActive,
          ),
          // if (answerOption.isCorrect) ...[const WellDonePopup()],
        ]);
  }
}
