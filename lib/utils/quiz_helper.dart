import 'package:edu_app/api/api.dart';
import 'package:edu_app/api/models/previous_question_response.dart';
import 'package:edu_app/api/models/validate_question_answer_response.dart';
import 'package:edu_app/models/question_status.dart';
import 'package:edu_app/models/quiz.dart';

class QuizHelper {
  static Future<QuizStateModel> validateQuestionAnswer(String sessionId,
      QuestionStatus status, String questionId, int answerIndex) async {
    ValidateQuestionAnswerResponse response =
        await EduloopApi.validateQuestionAnswer(sessionId, questionId, status,
            answerIndex: answerIndex);

    return response.quiz;
  }

  static Future<QuizStateModel> skipQuestion(
      String sessionId, String questionId) async {
    ValidateQuestionAnswerResponse response =
        await EduloopApi.validateQuestionAnswer(
            sessionId, questionId, QuestionStatus.skipped);

    return response.quiz;
  }

  static Future<QuizStateModel> getPreviousQuestion(String sessionId) async {
    PreviousQuestionResponse response =
        await EduloopApi.fetchPreviousQuestion(sessionId);

    return response.quiz;
  }
}
