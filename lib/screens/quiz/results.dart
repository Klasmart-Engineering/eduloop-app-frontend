import 'package:flutter/material.dart';
import 'package:edu_app/screens/quiz/quiz.dart';

class QuizResultsScreen extends StatelessWidget {
  const QuizResultsScreen({Key? key}) : super(key: key);

  static const routeName = 'quiz-results';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const <Widget>[HeadingSection()]),
        backgroundColor: Color.fromRGBO(210, 241, 198, 1));
  }
}

class HeadingSection extends StatelessWidget {
  const HeadingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 40),
            child: const Text(
              'Success!',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            child: const Text('Open route'),
            onPressed: () {
              Navigator.pushNamed(context, '/' + QuizScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
