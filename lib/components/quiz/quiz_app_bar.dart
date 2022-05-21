import 'package:edu_app/components/common/question_progress_indicator.dart';
import 'package:edu_app/models/quiz.dart';
import 'package:edu_app/providers/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizAppBar extends StatelessWidget {
  const QuizAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProviderModel>(builder: (context, quiz, child) {
      if (quiz.state != null) {
        return const CircularProgressIndicator();
      }

      return Row(
        children: [
          QuestionProgressIndicator(
            currentQuestion: quiz.state?.currentQuestionNumber ?? 0,
            totalQuestions: quiz.state?.totalNumberOfQuestions ?? 10,
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: OutlinedButton.icon(
                  label: Text(
                      quiz.state != null
                          ? quiz.state!.earnedScore.toString()
                          : '0',
                      style: const TextStyle(color: Colors.white)),
                  icon: const Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  onPressed: () => {},
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontWeight: FontWeight.bold)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36.0),
                      )),
                      side: MaterialStateProperty.all(const BorderSide(
                          color: Colors.white,
                          width: 1.0,
                          style: BorderStyle.solid)))))
        ],
      );
    });
  }
}
