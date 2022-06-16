import 'package:edu_app/components/quiz/question_view.dart';
import 'package:edu_app/components/quiz/quiz_carousel_nav_buttons.dart';
import 'package:edu_app/models/question.dart';
import 'package:edu_app/models/question_status.dart';
import 'package:edu_app/models/quiz_session.dart';
import 'package:edu_app/providers/session_provider.dart';
import 'package:edu_app/screens/quiz/results.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';

class QuizCarousel extends StatefulHookConsumerWidget {
  const QuizCarousel({Key? key}) : super(key: key);
  @override
  QuizCarouselState createState() => QuizCarouselState();
}

class QuizCarouselState extends ConsumerState<QuizCarousel> {
  CarouselController buttonCarouselController = CarouselController();

  Map<int, QuestionModel?> questions = {};
  int? initialQuestionNumber;
  int? totalNumberOfQuestions;

  bool enableButtons = false;

  @override
  void initState() {
    super.initState();
    //final session = ref.read(quizSessionProvider(null));
    setInitialQuizCarouselState();
  }

  Future<void> setInitialQuizCarouselState() async {
    final session = await ref.read(quizSessionProvider.future);

    if (session == null) {
      return;
    }

    setState(() {
      questions = {
        session.quiz.currentQuestionNumber: session.quiz.currentQuestion
      };
      initialQuestionNumber = session.quiz.currentQuestionNumber;
      totalNumberOfQuestions = session.quiz.totalNumberOfQuestions;
    });
  }

  /// When a button is pressed, we wait for api response so disable other actions in meantime
  void toggleButtons(bool enabled) {
    setState(() {
      enableButtons = enabled;
    });
  }

  void previousPage() {
    buttonCarouselController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);

    toggleButtons(true);
  }

  Future<void> nextPage() async {
    final quizSession = await ref.read(quizSessionProvider.future);

    if (quizSession == null) {
      return;
    }

    if (!quizSession.quiz.hasNextQuestion) {
      completeQuiz();
      return;
    }

    buttonCarouselController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);

    toggleButtons(true);
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
    toggleButtons(false);
    QuestionStatus status =
        isCorrect ? QuestionStatus.successful : QuestionStatus.failed;

    await ref
        .read(quizSessionProvider.notifier)
        .validateQuestionAnswer(answerIndex, status);

    if (isCorrect) {
      onCorrectAnswer();
    } else {
      onWrongAnswer();
    }
  }

  Future<void> goToPreviousQuestion() async {
    toggleButtons(false);
    await ref.read(quizSessionProvider.notifier).goToPreviousQuestion();
    previousPage();
  }

  Future<void> onSkip() async {
    toggleButtons(false);
    await ref.read(quizSessionProvider.notifier).skipQuestion();
    nextPage();
  }

  void completeQuiz() async {
    final session = await ref.read(quizSessionProvider.future);

    if (session == null) {
      return;
    }

    await ref.read(quizSessionProvider.notifier).closeSession();

    Navigator.pushNamed(context, '/' + QuizResultsScreen.routeName,
        arguments: QuizResultsScreenArguments(session.quiz.earnedScore,
            session.quiz.totalNumberOfQuestions, session.session.userId));
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Future<QuizSessionModel?>>(quizSessionProvider.future,
        (Future<QuizSessionModel?>? prevQuizSession,
            Future<QuizSessionModel?> newQuizSession) {
      newQuizSession.then((session) {
        if (session == null) {
          return;
        }

        setState(() {
          questions = {
            ...questions,
            session.quiz.currentQuestionNumber: session.quiz.currentQuestion
          };
        });
      });
    });

    if (initialQuestionNumber == null) {
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
                initialPage: initialQuestionNumber as int,
                aspectRatio: 1 / 1.4,
                enableInfiniteScroll: false),
            itemCount: totalNumberOfQuestions,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              bool questionExists = questions.containsKey(pageViewIndex);
              QuestionModel? currentQuestion =
                  questionExists ? questions[pageViewIndex] : null;

              if (currentQuestion == null) {
                return const Center(child: CircularProgressIndicator());
              }

              return Builder(
                builder: (BuildContext context) {
                  return QuestionView(
                    question: currentQuestion,
                    onAnswerSelection: onAnswerSelection,
                    enableButtons: enableButtons,
                  );
                },
              );
            },
          )),
      QuizCarouselNavigationButtons(
        nextPageTapHandler: onSkip,
        previousPageTapHandler: goToPreviousQuestion,
        enableButtons: enableButtons,
      )
    ]);
  }
}
