import 'package:edu_app/components/common/themed_button.dart';
import 'package:edu_app/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/screens/quiz/quiz.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  static const routeName = 'introduction';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(flex: 2, child: HeroImage()),
              Expanded(flex: 2, child: const HeadingSection())
            ]),
        backgroundColor: Color.fromRGBO(252, 230, 228, 1));
  }
}

class HeroImage extends StatelessWidget {
  const HeroImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Container(
          padding: EdgeInsets.all(20),
          color: Color.fromRGBO(169, 211, 243, 1),
        )),
        Image.asset('assets/images/couch_learning.png')
      ],
    );
  }
}

class HeadingSection extends StatelessWidget {
  const HeadingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Radius buttonRadius =
        Radius.circular(SizeConstants.elevatedButtonRadius);

    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10),
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
          Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8),
              child: ThemedButton.icon(
                  variant: ButtonVariant.secondary,
                  onPressed: () {
                    Navigator.pushNamed(context, '/' + QuizScreen.routeName);
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: buttonRadius,
                        topRight: buttonRadius,
                        bottomLeft: buttonRadius,
                        bottomRight: Radius.zero),
                  ))))),
        ],
      ),
    );
  }
}
