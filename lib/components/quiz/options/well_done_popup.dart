import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import 'package:google_fonts/google_fonts.dart';

// class WellDonePopup extends StatelessWidget {
//   const WellDonePopup({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // return Animator(
//     //   tweenMap: {
//     //     "opacity": Tween<double>(begin: 0, end: 1),
//     //     "translation":
//     //         Tween<Offset>(begin: Offset.zero, end: const Offset(0, -.5))
//     //   },
//     //   cycles: 0,
//     //   duration: const Duration(seconds: 1),
//     //   builder: (context, anim, child) => FadeTransition(
//     //       opacity: anim.getAnimation('opacity'),
//     //       child: FractionalTranslation(
//     //         translation: anim.getValue('translation'),
//     //         child: Text("Well done!",
//     //             textAlign: TextAlign.center,
//     //             style: GoogleFonts.dosis(
//     //                 color: Colors.black,
//     //                 fontWeight: FontWeight.w900,
//     //                 fontSize: 30,
//     //                 shadows: [
//     //                   const Shadow(
//     //                       // bottomLeft
//     //                       offset: Offset(-1.5, -1.5),
//     //                       color: Colors.white),
//     //                   const Shadow(
//     //                       // bottomRight
//     //                       offset: Offset(1.5, -1.5),
//     //                       color: Colors.white),
//     //                   const Shadow(
//     //                       // topRight
//     //                       offset: Offset(1.5, 1.5),
//     //                       color: Colors.white),
//     //                   const Shadow(
//     //                       // topLeft
//     //                       offset: Offset(-1.5, 1.5),
//     //                       color: Colors.white),
//     //                 ])),
//     //       )),
//     // );

//     return AnimateWidget(
//         duration: const Duration(milliseconds: 2000),
//         cycles: 2,
//         triggerOnRebuild: true,
//         triggerOnInit: false,
//         builder: (context, animate) {

//           return Text('Test');
//         });
//   }
// }

class WellDonePopup extends StatefulWidget {
  WellDonePopup({
    required this.animController,
    Key? key,
  }) : super(key: key);

  final AnimationController animController;

  @override
  WellDonePopupState createState() {
    return WellDonePopupState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class WellDonePopupState extends State<WellDonePopup> {
  late Animation opacityAnimation;
  late Animation transformAnimation;

  @override
  void initState() {
    super.initState();
    transformAnimation =
        Tween(begin: 0.00, end: 50.00).animate(widget.animController);

    opacityAnimation = TweenSequence(
      [
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.00), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 1.00, end: 0), weight: 1),
      ],
    ).animate(widget.animController);

    widget.animController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // bool buttonsAreInteractable =
    //     isNewQuestion && widget.enableButtons && lastOptionChosen == null;
    bool hasSpace = MediaQuery.of(context).size.width > 400;
    return Transform.translate(
        offset: Offset(0, -transformAnimation.value),
        child: Opacity(
            opacity: opacityAnimation.value,
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
                    ]))));
  }
}
