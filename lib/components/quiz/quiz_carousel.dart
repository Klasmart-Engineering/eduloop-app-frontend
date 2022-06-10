import 'package:edu_app/components/quiz/question_view.dart';
import 'package:edu_app/components/quiz/quiz_carousel_nav_buttons.dart';
import 'package:edu_app/models/question.dart';
import 'package:edu_app/models/question_status.dart';
import 'package:edu_app/providers/quiz_manager_provider.dart';
import 'package:edu_app/providers/session_provider.dart';
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
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  Future<void> nextPage() async {
    final quiz = await ref.read(quizManagerProvider.future);

    if (!quiz.state.hasNextQuestion) {
      completeQuiz();
      return;
    }

    buttonCarouselController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  void onCorrectAnswer() {
    ///celebrate good times
    Future.delayed(const Duration(milliseconds: 500), () {
      nextPage();
    });
  }

  void onWrongAnswer() {
    Future.delayed(const Duration(milliseconds: 500), () {
      nextPage();
    });
  }

  void onAnswerSelection(int answerIndex, bool isCorrect) async {
    QuestionStatus status =
        isCorrect ? QuestionStatus.successful : QuestionStatus.failed;

    await ref
        .read(quizManagerProvider.notifier)
        .validateQuestionAnswer(answerIndex, status);

    if (isCorrect) {
      onCorrectAnswer();
    } else {
      onWrongAnswer();
    }
  }

  Future<void> goToPreviousQuestion() async {
    await ref.read(quizManagerProvider.notifier).goToPreviousQuestion();
    previousPage();
  }

  Future<void> onSkip() async {
    await ref.read(quizManagerProvider.notifier).skipQuestion();
    nextPage();
  }

  void completeQuiz() async {
    final quiz = await ref.read(quizManagerProvider.future);
    final session = await ref.read(quizSessionProvider.future);
    await ref.read(quizSessionProvider.notifier).closeSession();
    Navigator.pushNamed(context, '/' + QuizResultsScreen.routeName,
        arguments: QuizResultsScreenArguments(quiz.state.earnedScore,
            quiz.state.totalNumberOfQuestions, session.userId));
  }

  @override
  Widget build(BuildContext context) {
    final quizListener = ref.watch(quizManagerProvider);

    if (quizListener is AsyncLoading) {
      return const Text('loading');
    }

    return Column(children: [
      Flexible(
          fit: FlexFit.tight,
          child: CarouselSlider.builder(
            carouselController: buttonCarouselController,
            options: CarouselOptions(
                viewportFraction: 1,
                enlargeCenterPage: true,
                initialPage: widget.initialQuestionNumber,
                aspectRatio: 1 / 1.4,
                enableInfiniteScroll: false),
            itemCount: widget.totalNumberOfQuestions,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              final quiz = quizListener.value;

              if (quiz == null) {
                return const Text('no data');
              }

              bool questionExists = quiz.questions.containsKey(pageViewIndex);
              QuestionModel? currentQuestion =
                  questionExists ? quiz.questions[pageViewIndex] : null;

              if (currentQuestion == null) {
                return const Center(child: CircularProgressIndicator());
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
          )),
      QuizCarouselNavigationButtons(
        nextPageTapHandler: onSkip,
        previousPageTapHandler: goToPreviousQuestion,
      )
    ]);
  }
}
