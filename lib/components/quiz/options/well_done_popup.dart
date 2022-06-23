import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import 'package:google_fonts/google_fonts.dart';

class WellDonePopup extends StatelessWidget {
  const WellDonePopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Animator(
      tweenMap: {
        "opacity": Tween<double>(begin: 0, end: 1),
        "translation":
            Tween<Offset>(begin: Offset.zero, end: const Offset(0, -.5))
      },
      cycles: 0,
      duration: const Duration(seconds: 1),
      builder: (context, anim, child) => FadeTransition(
          opacity: anim.getAnimation('opacity'),
          child: FractionalTranslation(
            translation: anim.getValue('translation'),
            child: Text("Well done!",
                textAlign: TextAlign.center,
                style: GoogleFonts.dosis(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    shadows: [
                      const Shadow(
                          // bottomLeft
                          offset: Offset(-1.5, -1.5),
                          color: Colors.white),
                      const Shadow(
                          // bottomRight
                          offset: Offset(1.5, -1.5),
                          color: Colors.white),
                      const Shadow(
                          // topRight
                          offset: Offset(1.5, 1.5),
                          color: Colors.white),
                      const Shadow(
                          // topLeft
                          offset: Offset(-1.5, 1.5),
                          color: Colors.white),
                    ])),
          )),
    );
  }
}
