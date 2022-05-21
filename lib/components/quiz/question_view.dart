import 'package:edu_app/components/quiz/question_options.dart';
import 'package:edu_app/models/question.dart';
import 'package:flutter/material.dart';

// Define a custom Form widget.
class QuestionView extends AppBar {
  QuestionView({
    required this.question,
    required this.onAnswerSelection,
    Key? key,
  }) : super(key: key);

  final QuestionModel question;
  final void Function(int index, bool isCorrect) onAnswerSelection;

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
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 300,
              margin: const EdgeInsets.symmetric(horizontal: 3.0),
              decoration: const BoxDecoration(color: Colors.orange),
            ),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(children: [
                    Text(
                      widget.question.type,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.question.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: SizedBox(
                            height: 100,
                            child: QuestionOptions(
                              questionStatus: widget.question.status,
                              chosenAnswerIndex:
                                  widget.question.chosenAnswerIndex,
                              items: widget.question.answers,
                              onAnswerSelection: widget.onAnswerSelection,
                            ))),
                  ]),
                )),
          ],
        ));
  }
}
