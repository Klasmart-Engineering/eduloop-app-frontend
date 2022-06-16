import 'package:edu_app/models/question.dart';
import 'package:edu_app/models/question_status.dart';
import 'package:flutter/material.dart';

// Define a custom Form widget.
class QuestionOptions extends AppBar {
  QuestionOptions({
    required this.items,
    required this.onAnswerSelection,
    required this.chosenAnswerIndex,
    required this.questionStatus,
    Key? key,
  }) : super(key: key);

  final List<AnswerModel> items;
  final void Function(int index, bool isCorrect) onAnswerSelection;
  final QuestionStatus questionStatus;
  final int? chosenAnswerIndex;

  @override
  QuestionOptionsState createState() {
    return QuestionOptionsState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class QuestionOptionsState extends State<QuestionOptions> {
  String lastOptionChosen = "";
  bool showHint = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleOptionButtonPress(String id, int index, bool isCorrect) {
    setState(() {
      lastOptionChosen = id;
      showHint = !isCorrect;
    });

    widget.onAnswerSelection(index, isCorrect);
  }

  Color getButtonBackgroundColor(
      Set<MaterialState> states, bool isActive, bool isCorrect) {
    // https://api.flutter.dev/flutter/material/MaterialStateProperty-class.html
    // const Set<MaterialState> interactiveStates = <MaterialState>{
    //   MaterialState.selected,
    //   MaterialState.pressed,
    //   MaterialState.focused,
    // };

    if (isActive) {
      return isCorrect ? Colors.green : Colors.red;
    }

    if (states.contains(MaterialState.disabled) && !isCorrect) {
      return Theme.of(context).colorScheme.tertiary.withOpacity(.5);
    }

    return Theme.of(context).colorScheme.tertiary;
  }

  Color getButtonTextColor(bool disabled, bool isActive, bool isCorrect) {
    if (isActive) {
      return Colors.white;
    }

    if (disabled && !isCorrect) {
      return Theme.of(context).colorScheme.onTertiary.withOpacity(.5);
    }

    return Theme.of(context).colorScheme.onTertiary;
  }

  Color getButtonBorderColor(
      Set<MaterialState> states, bool showHintOnThisButton) {
    if (showHintOnThisButton) {
      return Colors.green;
    }

    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    bool isNewQuestion = widget.questionStatus == QuestionStatus.fresh;
    bool buttonDisabled = !isNewQuestion || lastOptionChosen != "";

    return GridView.count(
        primary: false,
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 4 / 2,
        shrinkWrap: true,
        children: widget.items.map((item) {
          bool wasLastPressed = lastOptionChosen == item.clientId;
          bool isActive =
              wasLastPressed || item.answerIndex == widget.chosenAnswerIndex;
          return ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.resolveWith(
                    (states) => RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(
                          width: 3,
                          color: getButtonBorderColor(
                              states, item.isCorrect && showHint),
                        ))),
                backgroundColor: MaterialStateProperty.resolveWith((states) =>
                    getButtonBackgroundColor(
                        states, isActive, item.isCorrect))),
            child: Text(item.label,
                style: TextStyle(
                    color: getButtonTextColor(
                        buttonDisabled, isActive, item.isCorrect))),
            onPressed: buttonDisabled
                ? null
                : () {
                    handleOptionButtonPress(
                        item.clientId, item.answerIndex, item.isCorrect);
                  },
          );
        }).toList());
  }
}
