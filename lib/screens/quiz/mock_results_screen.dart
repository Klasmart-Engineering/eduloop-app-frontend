import 'package:confetti/confetti.dart';
import 'package:edu_app/components/user/sign_up_form.dart';
import 'package:edu_app/providers/session_provider.dart';
import 'package:edu_app/screens/introduction.dart';
import 'package:edu_app/screens/user/login.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class MockQuizResultsScreen extends StatefulHookConsumerWidget {
  const MockQuizResultsScreen({Key? key}) : super(key: key);

  static const routeName = 'quiz-results';

  @override
  MockQuizResultsScreenState createState() => MockQuizResultsScreenState();
}

class MockQuizResultsScreenState extends ConsumerState<MockQuizResultsScreen> {
  late ConfettiController _controllerTopCenter;
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  int? score = 10;
  int? maxScore = 10;
  String? uid = "234322343243243";

  @override
  void initState() {
    super.initState();

    _controllerTopCenter = ConfettiController();
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 1));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 1));

    _controllerCenterRight.play();
    _controllerCenterLeft.play();

    Future.delayed(const Duration(milliseconds: 3000), () {
      _controllerTopCenter.play();
    });
  }

  @override
  void dispose() {
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _controllerTopCenter.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   if (uid == null || score == null) return const Text('Loading');

  //   print('uid in results screen: $uid');

  //   return Scaffold(
  //       body: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 30),
  //                 child: Text(
  //                   score != null ? score.toString() : '0',
  //                   style: const TextStyle(
  //                     fontSize: 36,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 )),
  //             HeadingSection(
  //               userId: uid,
  //             )
  //           ]),
  //       backgroundColor: const Color.fromRGBO(191, 190, 253, 1));
  // }

  @override
  Widget build(BuildContext context) {
    if (uid == null || score == null) return const Text('Loading');

    print('uid in results screen: $uid');

    return Scaffold(
        body: SafeArea(
            child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            //CENTER --
            Align(
              heightFactor: 2,
              widthFactor: 2,
              alignment: Alignment.center,
              child: HeadingSection(
                score: score,
              ),
            ),
            //CENTER RIGHT -- Emit left
            Align(
              alignment: Alignment.centerRight,
              child: ConfettiWidget(
                confettiController: _controllerCenterRight,
                minBlastForce: 10,
                maxBlastForce: 20,
                blastDirection: 4, // radial value - RIGHT
                emissionFrequency: 0.4,
                numberOfParticles: 1,
                gravity: 0.1,
              ),
            ),
            //CENTER LEFT - Emit right
            Align(
              alignment: Alignment.centerLeft,
              child: ConfettiWidget(
                confettiController: _controllerCenterLeft,
                minBlastForce: 10,
                maxBlastForce: 20,
                blastDirection: 5.4, // radial value - RIGHT
                emissionFrequency: 0.4,
                numberOfParticles: 1,
                gravity: 0.1,
              ),
            ),
            //TOP CENTER - shoot down
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _controllerTopCenter,
                blastDirection: pi / 2,
                maxBlastForce: 1, // set a lower max blast force
                minBlastForce: 0.5, // set a lower min blast force
                emissionFrequency: 0.1,
                numberOfParticles: 1, // a lot of particles at once
                gravity: .0,
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: ActionSection(
                  userId: uid,
                )),
          ],
        )),
        backgroundColor: const Color.fromRGBO(191, 190, 253, 1));
  }
}

class HeadingSection extends HookConsumerWidget {
  const HeadingSection({Key? key, required this.score}) : super(key: key);

  final int? score;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Stack(alignment: Alignment.center, children: const [
                Icon(
                  Icons.star,
                  color: Color(0xFFFFD335),
                  size: 250,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      '5',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ))
              ])),
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'WOW!\nYou finished it all!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Amazing Work!',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
        ]);
  }
}

class ActionSection extends HookConsumerWidget {
  const ActionSection({Key? key, required this.userId}) : super(key: key);

  final String? userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        constraints: const BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                          ref
                              .watch(quizSessionProvider.notifier)
                              .startSession(userId as String)
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
