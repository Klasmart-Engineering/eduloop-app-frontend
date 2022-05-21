import 'dart:convert';

import 'package:edu_app/api/models/previous_question_response.dart';
import 'package:edu_app/api/models/session_response.dart';
import 'package:edu_app/api/models/validate_question_answer_response.dart';
import 'package:edu_app/models/question_status.dart';
import 'package:http/http.dart' as http;

class EduloopApi {
  //static String apiEndpoint = dotenv.env['EDULOOP_API_ENDPOINT'] ?? '';
  static String apiEndpoint =
      'https://8e60boe77b.execute-api.ap-northeast-2.amazonaws.com/question-manager';

  static Future<http.Response> baseApiPost(
      String action, Map? otherFields) async {
    final url = Uri.parse(apiEndpoint);
    final body = json.encode({
      'action': action,
      ...otherFields!,
    });

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //return Session.fromJson(jsonDecode(response.body));
      return response;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<SessionResponse> startSession(String userId) async {
    final response = await baseApiPost('start_session', {
      'uid': userId,
    });

    SessionResponse sessionResponse =
        SessionResponse.fromApiJson(jsonDecode(response.body));

    return sessionResponse;
  }

  static Future<PreviousQuestionResponse> fetchPreviousQuestion(
      String sessionId) async {
    final response = await baseApiPost('previous_question', {
      'sid': sessionId,
    });

    PreviousQuestionResponse previousQuestionResponse =
        PreviousQuestionResponse.fromApiJson(jsonDecode(response.body));

    return previousQuestionResponse;
  }

  static Future<ValidateQuestionAnswerResponse> validateQuestionAnswer(
      String sessionId, String questionId, QuestionStatus status,
      {int? answerIndex}) async {
    final response = await baseApiPost('question_response', {
      'sid': sessionId,
      'qid': questionId,
      'status': status.string,
      'answer_idx': answerIndex,
    });

    ValidateQuestionAnswerResponse validateQuestionAnswerResponse =
        ValidateQuestionAnswerResponse.fromApiJson(jsonDecode(response.body));

    return validateQuestionAnswerResponse;
  }
}
