import 'package:edu_app/api/api.dart';
import 'package:edu_app/api/models/previous_question_response.dart';
import 'package:edu_app/api/models/validate_question_answer_response.dart';
import 'package:edu_app/models/question_status.dart';
import 'package:edu_app/models/quiz_state.dart';

class QuizService {
  static Future<QuizStateModel> validateQuestionAnswer(
      String sessionId,
      QuestionStatus status,
      QuizStateModel currentQuizState,
      int answerIndex) async {
    ValidateQuestionAnswerResponse response =
        await EduloopApi.validateQuestionAnswer(
            sessionId,
            currentQuizState.currentQuestion.id,
            status,
            currentQuizState.questionSentUTC,
            currentQuizState.questionReceivedUTC,
            answerIndex: answerIndex);

    return response.quiz;
  }

  static Future<QuizStateModel> skipQuestion(
    String sessionId,
    QuizStateModel currentQuizState,
  ) async {
    ValidateQuestionAnswerResponse response =
        await EduloopApi.validateQuestionAnswer(
            sessionId,
            currentQuizState.currentQuestion.id,
            QuestionStatus.skipped,
            currentQuizState.questionSentUTC,
            currentQuizState.questionReceivedUTC);

    return response.quiz;
  }

  static Future<QuizStateModel> getPreviousQuestion(String sessionId) async {
    PreviousQuestionResponse response =
        await EduloopApi.fetchPreviousQuestion(sessionId);

    return response.quiz;
  }
}
