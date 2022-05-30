// https://stackoverflow.com/questions/53931513/store-data-as-an-object-in-shared-preferences-in-flutter
import 'package:edu_app/models/quiz.dart';
import 'package:edu_app/models/session.dart';
import 'package:flutter/material.dart';

class PreviousQuestionResponse {
  final QuizStateModel quiz;

  PreviousQuestionResponse({required this.quiz});

  factory PreviousQuestionResponse.fromApiJson(Map<String, dynamic> json) {
    return PreviousQuestionResponse(
      quiz: QuizStateModel.fromApiJson(json),
    );
  }
}
