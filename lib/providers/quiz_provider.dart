// https://stackoverflow.com/questions/53931513/store-data-as-an-object-in-shared-preferences-in-flutter
import 'package:edu_app/models/question.dart';
import 'package:edu_app/models/question_status.dart';
import 'package:edu_app/models/quiz.dart';
import 'package:edu_app/models/session.dart';
import 'package:edu_app/utils/quiz_helper.dart';
import 'package:edu_app/utils/session_helper.dart';
import 'package:flutter/material.dart';

class QuizProviderModel extends ChangeNotifier {
  // int totalQuestions = 5;
  // int currentQuestionNumber = 1;
  // int currentScore = 0;

  final Map<int, QuestionModel?> questions = {};

  late SessionModel session;
  // Purely used for first load with future builder
  late Future<QuizStateModel?> initialState;
  QuizStateModel? state;

  QuizProviderModel() {
    print("initial loading");

    SessionHelper.getSessionFromStorage().then((value) {
      if (value == null) {
        return;
      }

      session = value;
    });

    initialState = QuizHelper.getQuizFromStorage().then((value) {
      if (value == null) {
        throw Exception('Quiz state not found');
      }

      updateQuizState(value);
    });
  }

  void updateQuizState(QuizStateModel quizState) {
    state = quizState;
    questions[quizState.currentQuestionNumber] = quizState.currentQuestion;
    QuizHelper.updateQuizInStorage(quizState);
  }

  // bool isQuizComplete() {
  //   return totalQuestions == currentQuestionNumber;
  // }

  Future<QuizStateModel?> validateQuestionAnswer(
      int answerIndex, QuestionStatus status) async {
    String sessionId = session.id;

    String questionId = state?.currentQuestion.id ?? '';

    QuizStateModel? newQuizState = await QuizHelper.validateQuestionAnswer(
        sessionId, status, questionId, answerIndex);

    if (newQuizState == null) {
      return null;
    }

    updateQuizState(newQuizState);

    return newQuizState;
  }

  Future<QuizStateModel?> skipQuestion() async {
    String sessionId = session.id;
    String questionId = state?.currentQuestion.id ?? '';

    QuizStateModel? newQuizState =
        await QuizHelper.skipQuestion(sessionId, questionId);

    if (newQuizState == null) {
      return null;
    }

    updateQuizState(newQuizState);

    return newQuizState;
  }
}
