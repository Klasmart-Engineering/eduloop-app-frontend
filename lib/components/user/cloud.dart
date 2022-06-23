import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

class Cloud extends StatelessWidget {
  const Cloud(
      {this.delay = 0,
      this.duration = const Duration(seconds: 2),
      this.scale = .8,
      Key? key})
      : super(key: key);

  final Duration duration;
  final double delay;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Animator(
        curve: Interval(delay, 1, curve: Curves.linear),
        tweenMap: {
          "translation":
              Tween<Offset>(begin: Offset.zero, end: const Offset(0, -.5))
        },
        cycles: 0,
        duration: duration,
        builder: (context, anim, child) => FractionalTranslation(
            translation: anim.getValue('translation'),
            child: Image.asset(
              'assets/images/cloud.png',
              scale: scale,
            )));
  }
}
