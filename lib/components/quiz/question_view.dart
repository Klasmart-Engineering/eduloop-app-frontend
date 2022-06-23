import 'package:edu_app/components/quiz/question_options.dart';
import 'package:edu_app/models/question.dart';
import 'package:flutter/material.dart';

// Define a custom Form widget.
class QuestionView extends AppBar {
  QuestionView({
    required this.question,
    required this.onAnswerSelection,
    required this.enableButtons,
    Key? key,
  }) : super(key: key);

  final QuestionModel question;
  final void Function(int index, bool isCorrect) onAnswerSelection;
  final bool enableButtons;

  @override
  QuestionViewState createState() {
    return QuestionViewState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class QuestionViewState extends State<QuestionView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.question.assetUrl),
                  )),
            ),
            Expanded(
                child: Container(
              height: double.maxFinite,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(
                  children: [
                    Text(
                      widget.question.type,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.question.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                    child: QuestionOptions(
                  enableButtons: widget.enableButtons,
                  questionStatus: widget.question.status,
                  chosenAnswerIndex: widget.question.chosenAnswerIndex,
                  items: widget.question.answers,
                  onAnswerSelection: widget.onAnswerSelection,
                )),
              ]),
            )),
          ],
        ));
  }
}
