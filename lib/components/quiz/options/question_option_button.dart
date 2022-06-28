import 'package:edu_app/components/common/themed_button.dart';
import 'package:edu_app/models/question.dart';
import 'package:flutter/material.dart';

import 'well_done_popup.dart';

class QuestionOptionButton extends StatefulWidget {
  const QuestionOptionButton(
      {Key? key,
      required this.onPressed,
      required this.answerOption,
      this.chosenAnswerIndex})
      : super(key: key);

  final void Function(AnswerModel answerOption)? onPressed;
  final int? chosenAnswerIndex;
  final AnswerModel answerOption;

  @override
  QuestionOptionButtonState createState() {
    return QuestionOptionButtonState();
  }
}

class QuestionOptionButtonState extends State<QuestionOptionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController wellDonePopupAnimationController;

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
  void initState() {
    super.initState();
    wellDonePopupAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    super.dispose();
    wellDonePopupAnimationController.dispose();
  }

  void handleOnPress(AnswerModel optionChosen) {
    if (optionChosen.isCorrect) {
      wellDonePopupAnimationController.forward();
    }
    widget.onPressed!(optionChosen);
  }

  @override
  Widget build(BuildContext context) {
    bool answerHasBeenChosen = widget.chosenAnswerIndex != null;
    bool chosenAnswer =
        widget.chosenAnswerIndex == widget.answerOption.answerIndex;
    bool stayVisiblyActive = chosenAnswer || widget.answerOption.isCorrect;

    ButtonStyle baseStyle = ButtonStyle(
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 5, horizontal: 10)));
    ButtonStyle colourStyle = displayCorrectAnswer(
        answerHasBeenChosen, widget.answerOption.isCorrect, chosenAnswer);

    /// We still want the right answer and chosen answer to stay visible state, so we provide a hollow function to them
    Function() clickHandler = answerHasBeenChosen
        ? () {}
        : () {
            handleOnPress(widget.answerOption);
          };

    return GestureDetector(
        onTap: clickHandler,
        child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.topCenter,
            children: [
              ThemedButton(
                variant: ButtonVariant.tertiary,
                label: Center(
                    child: Text(
                  widget.answerOption.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(overflow: TextOverflow.visible),
                )),
                onPressed: () => {},
                style: baseStyle.merge(colourStyle),
                isActive: !answerHasBeenChosen || stayVisiblyActive,
              ),
              if (widget.answerOption.isCorrect) ...[
                WellDonePopup(animController: wellDonePopupAnimationController)
              ],
            ]));
  }
}
