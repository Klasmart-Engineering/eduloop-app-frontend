// https://stackoverflow.com/questions/53931513/store-data-as-an-object-in-shared-preferences-in-flutter
import 'package:edu_app/models/quiz.dart';
import 'package:edu_app/models/session.dart';
import 'package:flutter/material.dart';

class PreviousQuestionResponse {
  final bool noPreviousQuestion;

  PreviousQuestionResponse({required this.noPreviousQuestion});

  factory PreviousQuestionResponse.fromApiJson(
      Map<String, dynamic> parsedJson) {
    return PreviousQuestionResponse(
      noPreviousQuestion: parsedJson['no_previous_question'],
    );
  }
}
