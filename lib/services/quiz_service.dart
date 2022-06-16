import 'package:edu_app/api/api.dart';
import 'package:edu_app/api/models/previous_question_response.dart';
import 'package:edu_app/api/models/validate_question_answer_response.dart';
import 'package:edu_app/models/question_status.dart';
import 'package:edu_app/models/quiz_session.dart';
import 'package:edu_app/models/quiz_state.dart';
import 'package:edu_app/models/session.dart';

class QuizService {
  static Future<QuizSessionModel> validateQuestionAnswer(
      SessionModel session,
      QuestionStatus status,
      QuizStateModel currentQuizState,
      int answerIndex) async {
    ValidateQuestionAnswerResponse response =
        await EduloopApi.validateQuestionAnswer(
            session.id,
            session.userId,
            currentQuizState.currentQuestion.id,
            status,
            currentQuizState.questionSentUTC,
            currentQuizState.questionReceivedUTC,
            answerIndex: answerIndex);

    return response.quiz;
  }

  static Future<QuizSessionModel> skipQuestion(
    SessionModel session,
    QuizStateModel currentQuizState,
  ) async {
    ValidateQuestionAnswerResponse response =
        await EduloopApi.validateQuestionAnswer(
            session.id,
            session.userId,
            currentQuizState.currentQuestion.id,
            QuestionStatus.skipped,
            currentQuizState.questionSentUTC,
            currentQuizState.questionReceivedUTC);

    return response.quiz;
  }

  static Future<QuizSessionModel> getPreviousQuestion(
      SessionModel session) async {
    PreviousQuestionResponse response =
        await EduloopApi.fetchPreviousQuestion(session.id, session.userId);

    return response.quiz;
  }
}
