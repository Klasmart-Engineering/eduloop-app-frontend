import 'package:flutter/material.dart';

class QuestionProgressIndicator extends StatefulWidget {
  const QuestionProgressIndicator(
      {required this.currentQuestion, required this.totalQuestions, Key? key})
      : super(key: key);

  final int currentQuestion;
  final int totalQuestions;

  @override
  State<QuestionProgressIndicator> createState() =>
      _QuestionProgressIndicatorState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _QuestionProgressIndicatorState extends State<QuestionProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int progress = widget.currentQuestion;
    controller.value = progress / widget.totalQuestions;

    return CircularProgressIndicator(
      value: controller.value,
      backgroundColor: Colors.amber,
      strokeWidth: 7,
      semanticsLabel: 'Linear progress indicator',
    );
  }
}
