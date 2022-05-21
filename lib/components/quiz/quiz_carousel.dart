import 'package:carousel_slider/carousel_slider.dart';
import 'package:edu_app/components/quiz/question_view.dart';
import 'package:edu_app/models/question.dart';
import 'package:edu_app/models/question_status.dart';
import 'package:edu_app/providers/quiz_provider.dart';
import 'package:edu_app/screens/quiz/results.dart';
import 'package:edu_app/utils/question_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'quiz_carousel_nav_buttons.dart';

// Define a custom Form widget.
class QuizCarousel extends StatefulWidget {
  const QuizCarousel({Key? key}) : super(key: key);

  @override
  QuizCarouselState createState() {
    return QuizCarouselState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class QuizCarouselState extends State<QuizCarousel> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void previousPage() {
    // Provider.of<QuizProviderModel>(context, listen: false)
    //     .decrementQuestionNumber();
    buttonCarouselController.previousPage();
  }

  void nextPage() {
    QuizProviderModel quizProvider =
        Provider.of<QuizProviderModel>(context, listen: false);
    if (quizProvider.isQuizComplete()) {
      goToResultsScreen();
      return;
    }

    //quizProvider.incrementQuestionNumber();
    buttonCarouselController.nextPage();
  }

  void onCorrectAnswer() {
    //Provider.of<QuizProviderModel>(context, listen: false).incrementScore();

    ///celebrate good times
    Future.delayed(const Duration(milliseconds: 1000), () {
      nextPage();
    });
  }

  void onWrongAnswer() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      nextPage();
    });
  }

  void onAnswerSelection(int answerIndex, bool isCorrect) {
    QuizProviderModel quizProvider =
        Provider.of<QuizProviderModel>(context, listen: false);

    QuestionStatus status =
        isCorrect ? QuestionStatus.successful : QuestionStatus.failed;
    quizProvider.validateQuestionAnswer(answerIndex, status).then((newState) {
      if (isCorrect) {
        onCorrectAnswer();
      } else {
        onWrongAnswer();
      }
    });
  }

  void onSkip() {
    QuizProviderModel quizProvider =
        Provider.of<QuizProviderModel>(context, listen: false);

    quizProvider.skipQuestion().then((newState) {
      nextPage();
    });
  }

  void goToResultsScreen() {
    Navigator.pushNamed(context, '/' + QuizResultsScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider.builder(
        carouselController: buttonCarouselController,
        options: CarouselOptions(
            viewportFraction: 1,
            enlargeCenterPage: true,
            initialPage: Provider.of<QuizProviderModel>(context, listen: false)
                .state
                .currentQuestionNumber,
            aspectRatio: 1 / 1.4,
            enableInfiniteScroll: false),
        itemCount: Provider.of<QuizProviderModel>(context, listen: false)
            .totalQuestions,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          QuizProviderModel questionProvider =
              Provider.of<QuizProviderModel>(context, listen: false);
          bool questionExists =
              questionProvider.questions.containsKey(pageViewIndex);

          print(questionProvider.questions);
          print('current question ${questionProvider.currentQuestionNumber}');
          print('index: ${itemIndex}');
          print('page index: ${pageViewIndex}');
          QuestionModel? currentQuestion =
              questionExists ? questionProvider.questions[pageViewIndex] : null;

          if (currentQuestion == null) {
            return const CircularProgressIndicator();
          }

          return Builder(
            builder: (BuildContext context) {
              return QuestionView(
                question: currentQuestion,
                onAnswerSelection: onAnswerSelection,
              );
            },
          );
        },
      ),
      QuizCarouselNavigationButtons(
        nextPageTapHandler: onSkip,
        previousPageTapHandler: previousPage,
      )
    ]);
  }
}
