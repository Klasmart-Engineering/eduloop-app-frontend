import 'dart:convert';

import 'package:edu_app/api/models/api_action_type.dart';
import 'package:edu_app/api/models/base_response.dart';
import 'package:edu_app/api/models/previous_question_response.dart';
import 'package:edu_app/api/models/start_session_response.dart';
import 'package:edu_app/api/models/validate_question_answer_response.dart';
import 'package:edu_app/models/question_status.dart';
import 'package:http/http.dart' as http;

class EduloopApi {
  //static String apiEndpoint = dotenv.env['EDULOOP_API_ENDPOINT'] ?? '';
  static String apiEndpoint =
      'https://8e60boe77b.execute-api.ap-northeast-2.amazonaws.com/question-manager';

  static Future<http.Response> baseApiPost(
      ApiActionType action, Map? otherFields) async {
    final url = Uri.parse(apiEndpoint);
    final body = json.encode({
      'action': action.string,
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
      throw Exception('Failed to call api action ${action.string}');
    }
  }

  static Future<StartSessionResponse> startSession(String userId) async {
    final response = await baseApiPost(ApiActionType.startSession, {
      'uid': userId,
    });

    return StartSessionResponse.fromApiJson(jsonDecode(response.body));
  }

  static Future<BaseResponse> closeSession(
      String userId, String sessionId) async {
    final response = await baseApiPost(ApiActionType.closeSession, {
      'uid': userId,
      'sid': sessionId,
    });

    return BaseResponse.fromApiJson(jsonDecode(response.body));
  }

  static Future<PreviousQuestionResponse> fetchPreviousQuestion(
      String sessionId, String userId) async {
    final response = await baseApiPost(ApiActionType.previousQuestion, {
      'sid': sessionId,
      'uid': userId,
    });

    return PreviousQuestionResponse.fromApiJson(jsonDecode(response.body));
  }

  static Future<ValidateQuestionAnswerResponse> validateQuestionAnswer(
      String sessionId,
      String userId,
      String questionId,
      QuestionStatus status,
      int questionSentUTC,
      int questionReceivedUTC,
      {int? answerIndex}) async {
    final int utcNow = DateTime.now().toUtc().millisecondsSinceEpoch;

    final response = await baseApiPost(ApiActionType.validateQuestionResponse, {
      'sid': sessionId,
      'qid': questionId,
      'uid': userId,
      'status': status.string,
      'answer_idx': answerIndex,
      'question_sent_utc': null,
      'question_received_utc': null,
      'response_sent_utc': utcNow
    });

    return ValidateQuestionAnswerResponse.fromApiJson(
        jsonDecode(response.body));
  }
}
