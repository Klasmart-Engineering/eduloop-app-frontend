import 'package:edu_app/components/common/themed_button.dart';
import 'package:edu_app/components/quiz/options/question_option_button.dart';
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
    required this.enableButtons,
    Key? key,
  }) : super(key: key);

  final List<AnswerModel> items;
  final void Function(int index, bool isCorrect) onAnswerSelection;
  final QuestionStatus questionStatus;

  // This prop helps us show historic answers
  final int? chosenAnswerIndex;
  final bool enableButtons;

  @override
  QuestionOptionsState createState() {
    return QuestionOptionsState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class QuestionOptionsState extends State<QuestionOptions> {
  int? lastOptionChosen;
  bool showHint = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleOptionButtonPress(AnswerModel answer) {
    setState(() {
      lastOptionChosen = answer.answerIndex;
    });

    widget.onAnswerSelection(answer.answerIndex, answer.isCorrect);
  }

  void mockHandleOptionButtonPress(String id) {
    setState(() {
      //lastOptionChosen = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isNewQuestion = widget.questionStatus == QuestionStatus.fresh;
    // bool buttonsAreInteractable =
    //     isNewQuestion && widget.enableButtons && lastOptionChosen == null;
    bool hasSpace = MediaQuery.of(context).size.width > 400;
    return GridView.count(
        primary: false,
        clipBehavior: Clip.none,
        crossAxisCount: 2,
        mainAxisSpacing: hasSpace ? 20 : 10,
        crossAxisSpacing: hasSpace ? 20 : 10,
        childAspectRatio: 4 / 2,
        shrinkWrap: true,
        padding: EdgeInsets.all(hasSpace ? 10 : 0),
        children: widget.items.map((answerOption) {
          return QuestionOptionButton(
              chosenAnswerIndex: widget.chosenAnswerIndex ?? lastOptionChosen,
              onPressed: handleOptionButtonPress,
              answerOption: answerOption);
        }).toList());
  }
}
