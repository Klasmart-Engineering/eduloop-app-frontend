// https://stackoverflow.com/questions/53931513/store-data-as-an-object-in-shared-preferences-in-flutter
import 'dart:math';

import 'package:edu_app/api/models/base_response.dart';
import 'package:edu_app/models/quiz_session.dart';
import 'package:edu_app/models/quiz_state.dart';
import 'package:edu_app/models/session.dart';

class StartSessionResponse extends BaseResponse {
  final QuizSessionModel quizSession;

  StartSessionResponse({required this.quizSession, required successful, errmsg})
      : super(successful: successful, errmsg: errmsg);

  factory StartSessionResponse.fromApiJson(Map<String, dynamic> json) {
    return StartSessionResponse(
      quizSession: QuizSessionModel.fromApiJson(json),
      successful: json['successful'],
      errmsg: json['errmsg'],
    );
  }
}
