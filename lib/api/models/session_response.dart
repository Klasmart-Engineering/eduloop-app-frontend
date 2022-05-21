// https://stackoverflow.com/questions/53931513/store-data-as-an-object-in-shared-preferences-in-flutter
import 'package:edu_app/models/quiz.dart';
import 'package:edu_app/models/session.dart';
import 'package:flutter/material.dart';

class SessionResponse {
  final SessionModel session;
  final QuizStateModel quiz;

  SessionResponse({
    required this.session,
    required this.quiz,
  });

  factory SessionResponse.fromApiJson(Map<String, dynamic> parsedJson) {
    return SessionResponse(
      session: SessionModel.fromApiJson(parsedJson),
      quiz: QuizStateModel.fromApiJson(parsedJson),
    );
  }
}
