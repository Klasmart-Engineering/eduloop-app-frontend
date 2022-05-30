import 'package:edu_app/components/common/question_progress_indicator.dart';
import 'package:edu_app/components/quiz/question_view.dart';
import 'package:edu_app/components/quiz/quiz_carousel_nav_buttons.dart';
import 'package:edu_app/models/question.dart';
import 'package:edu_app/models/question_status.dart';
import 'package:edu_app/providers/riverpod/quiz_data.dart';
import 'package:edu_app/screens/quiz/results.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';

class QuizCarousel extends StatefulHookConsumerWidget {
  const QuizCarousel(
      {required this.initialQuestionNumber,
      required this.totalNumberOfQuestions,
      Key? key})
      : super(key: key);

  final int initialQuestionNumber;
  final int totalNumberOfQuestions;

  @override
  QuizCarouselState createState() => QuizCarouselState();
}

class QuizCarouselState extends ConsumerState<QuizCarousel> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  void previousPage() {
    buttonCarouselController.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  Future<void> nextPage() async {
    final state = await ref.read(quizDataProvider.future);

    if (!state.quiz.hasNextQuestion) {
      goToResultsScreen();
      return;
    }

    buttonCarouselController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  void onCorrectAnswer() {
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

  void onAnswerSelection(int answerIndex, bool isCorrect) async {
    QuestionStatus status =
        isCorrect ? QuestionStatus.successful : QuestionStatus.failed;

    await ref
        .read(quizDataProvider.notifier)
        .validateQuestionAnswer(answerIndex, status);

    if (isCorrect) {
      onCorrectAnswer();
    } else {
      onWrongAnswer();
    }
  }

  Future<void> goToPreviousQuestion() async {
    await ref.read(quizDataProvider.notifier).goToPreviousQuestion();
    previousPage();
  }

  Future<void> onSkip() async {
    await ref.read(quizDataProvider.notifier).skipQuestion();
    nextPage();
  }

  void goToResultsScreen() {
    Navigator.pushNamed(context, '/' + QuizResultsScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    print('CAROUSEL initial: ${widget.initialQuestionNumber}');
    print('CAROUSEL max: ${widget.totalNumberOfQuestions}');

    return Column(children: [
      CarouselSlider.builder(
        carouselController: buttonCarouselController,
        options: CarouselOptions(
            viewportFraction: 1,
            enlargeCenterPage: true,
            initialPage: widget.initialQuestionNumber,
            aspectRatio: 1 / 1.4,
            enableInfiniteScroll: false),
        itemCount: widget.totalNumberOfQuestions,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          final quizListener = ref.watch(quizDataProvider);

          if (quizListener is AsyncLoading) {
            return const Text('loading');
          }

          final data = quizListener.value;

          if (data == null) {
            return const Text('no data');
          }

          print("render new page");
          bool questionExists = data.questions.containsKey(pageViewIndex);
          //bool questionExists = false;
          print('after q exists');
          // print('initial question ${data.initialQuestionNumber}');
          // print('current question ${data.quiz.currentQuestionNumber}');
          print('index: ${itemIndex}');
          print('page index: ${pageViewIndex}');
          QuestionModel? currentQuestion =
              questionExists ? data.questions[pageViewIndex] : null;
          //QuestionModel? currentQuestion = null;
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
        previousPageTapHandler: goToPreviousQuestion,
      )
    ]);
  }
}
