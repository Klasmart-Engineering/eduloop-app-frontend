import 'dart:convert';

import 'package:edu_app/models/question.dart';
import 'package:edu_app/models/question_status.dart';
import 'package:flutter/material.dart';

class QuestionService {
  static QuestionModel getNextQuestion(int questionNumber) {
    List<AnswerModel> answers = <AnswerModel>[];

    QuestionModel newQuestion = QuestionModel(
        id: UniqueKey().toString(),
        title: 'This is a question?',
        type: 'Find the Shape',
        answers: answers,
        status: QuestionStatus.fresh,
        assetUrl: 'wwww.images.com',
        chosenAnswerIndex: 0);

    return newQuestion;
  }
}
