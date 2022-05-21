import 'dart:convert';
import 'package:edu_app/api/api.dart';
import 'package:edu_app/api/models/validate_question_answer_response.dart';
import 'package:edu_app/models/question_status.dart';
import 'package:edu_app/models/quiz.dart';
import 'package:edu_app/providers/quiz_provider.dart';
import 'package:edu_app/utils/local_storage_helper.dart';
import 'package:edu_app/constants/storage_keys.dart';
import 'package:provider/provider.dart';

class QuizHelper {
  static Future<QuizStateModel?> getQuizFromStorage() async {
    String? quizValue = await LocalStorageHelper.get(keyQuiz);

    if (quizValue == null) {
      // refetch
      return null;
    }

    var quizJson = jsonDecode(quizValue);
    return QuizStateModel.fromJson(quizJson);
  }

  static void updateQuizInStorage(QuizStateModel state) async {
    String quizStateJson = jsonEncode(state);
    LocalStorageHelper.store(keyQuiz, quizStateJson);
  }

  static Future<QuizStateModel> validateQuestionAnswer(String sessionId,
      QuestionStatus status, String questionId, int answerIndex) async {
    ValidateQuestionAnswerResponse response =
        await EduloopApi.validateQuestionAnswer(sessionId, questionId, status,
            answerIndex: answerIndex);

    return response.quiz;
  }

  static Future<QuizStateModel?> skipQuestion(
      String sessionId, String questionId) async {
    ValidateQuestionAnswerResponse response =
        await EduloopApi.validateQuestionAnswer(
            sessionId, questionId, QuestionStatus.skipped);

    return response.quiz;
  }
}
