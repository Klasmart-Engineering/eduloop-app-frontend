import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionScoreLabel extends StatefulHookConsumerWidget {
  const QuestionScoreLabel({required this.score, Key? key}) : super(key: key);

  final int score;
  @override
  QuestionScoreLabelState createState() => QuestionScoreLabelState();
}

class QuestionScoreLabelState extends ConsumerState<QuestionScoreLabel> {
  late ConfettiController _confettiStarController;

  @override
  void initState() {
    super.initState();

    _confettiStarController =
        ConfettiController(duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _confettiStarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    useValueChanged(widget.score, (oldValue, oldResult) {
      _confettiStarController.play();
      return widget.score;
    });

    return OutlinedButton.icon(
        label: Text(widget.score.toString(),
            style: const TextStyle(color: Colors.black, fontSize: 20)),
        icon: Stack(children: [
          ConfettiWidget(
            confettiController: _confettiStarController,
            blastDirectionality: BlastDirectionality
                .explosive, // don't specify a direction, blast randomly
            shouldLoop:
                false, // start again as soon as the animation is finished
            colors: const [
              Color(0xFFFFD335)
            ], // manually specify the colors to be used
            createParticlePath: drawStar, // define a custom shape/path.
            gravity: .05,
            strokeColor: Colors.white,
            strokeWidth: 2,
            minimumSize: Size(20, 20),
            maximumSize: Size(30, 30),
          ),
          const Icon(
            Icons.star,
            color: Color(0xFFFFD335),
          )
        ]),
        onPressed: () => {},
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15)),
            textStyle: MaterialStateProperty.all(
                const TextStyle(fontWeight: FontWeight.bold)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36.0),
            ))));
  }
}

Path drawStar(Size size) {
  // Method to convert degree to radians
  double degToRad(double deg) => deg * (pi / 180.0);

  const numberOfPoints = 5;
  final halfWidth = size.width / 2;
  final externalRadius = halfWidth;
  final internalRadius = halfWidth / 2.5;
  final degreesPerStep = degToRad(360 / numberOfPoints);
  final halfDegreesPerStep = degreesPerStep / 2;
  final path = Path();
  final fullAngle = degToRad(360);
  path.moveTo(size.width, halfWidth);

  for (double step = 0; step < fullAngle; step += degreesPerStep) {
    path.lineTo(halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step));
    path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep));
  }
  path.close();
  return path;
}
