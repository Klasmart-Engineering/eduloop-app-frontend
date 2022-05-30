import 'package:flutter/material.dart';
import 'package:edu_app/screens/quiz/quiz.dart';

class QuizResultsScreen extends StatelessWidget {
  const QuizResultsScreen({Key? key}) : super(key: key);

  static const routeName = 'quiz-results';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    '100',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              HeadingSection()
            ]),
        backgroundColor: Color.fromRGBO(191, 190, 253, 1));
  }
}

class HeadingSection extends StatelessWidget {
  const HeadingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: const Text(
                'WOW!\nYou finished it all!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 12),
              child: const Text(
                'Amazing Work!',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 25))),
                      child: const Text('Lets start again!',
                          style: TextStyle(fontSize: 20)),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/' + QuizScreen.routeName);
                      },
                    ))),
          ],
        ));
  }
}
