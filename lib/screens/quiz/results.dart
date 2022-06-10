import 'package:edu_app/screens/introduction.dart';
import 'package:edu_app/screens/user/login.dart';
import 'package:edu_app/services/session_service.dart';
import 'package:flutter/material.dart';

class QuizResultsScreenArguments {
  final int score;
  final int maxScore;

  final String uid;

  QuizResultsScreenArguments(this.score, this.maxScore, this.uid);
}

class QuizResultsScreen extends StatefulWidget {
  const QuizResultsScreen({Key? key}) : super(key: key);

  static const routeName = 'quiz-results';

  @override
  State<QuizResultsScreen> createState() => _QuizResultsScreenState();
}

class _QuizResultsScreenState extends State<QuizResultsScreen> {
  int? score;
  int? maxScore;
  String? uid;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)!.settings.arguments
        as QuizResultsScreenArguments?;

    if (args == null) {
      Navigator.pushNamed(context, '/' + LoginScreen.routeName);
      return;
    }

    score = args.score;
    maxScore = args.maxScore;
    uid = args.uid;
  }

  @override
  Widget build(BuildContext context) {
    if (uid == null || score == null) return const Text('Loading');

    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    score != null ? score.toString() : '0',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              HeadingSection(
                userId: uid,
              )
            ]),
        backgroundColor: const Color.fromRGBO(191, 190, 253, 1));
  }
}

class HeadingSection extends StatelessWidget {
  const HeadingSection({Key? key, required this.userId}) : super(key: key);

  final String? userId;

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
              child: userId != null
                  ? SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 25))),
                        child: const Text('Lets start again!',
                            style: TextStyle(fontSize: 20)),
                        onPressed: () {
                          SessionService.startSession(userId as String)
                              .then((value) {
                            Navigator.pushNamed(
                                context, '/' + IntroductionScreen.routeName);
                          });
                        },
                      ))
                  : null,
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
                      child: const Text('Back to Login',
                          style: TextStyle(fontSize: 20)),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/' + LoginScreen.routeName);
                      },
                    )))
          ],
        ));
  }
}
