import 'package:flutter/material.dart';
import 'package:edu_app/screens/quiz/quiz.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  static const routeName = 'introduction';

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
              'Lets starts\nLearning!',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 12),
            child: const Text(
              'By clicking next, you authorise the user of your data for use of enhancement of badanamu products!',
              style: TextStyle(
                fontSize: 16,
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
