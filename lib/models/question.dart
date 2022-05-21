// https://stackoverflow.com/QuestionModels/53931513/store-data-as-an-object-in-shared-preferences-in-flutter
import 'dart:convert';

import 'package:edu_app/models/question_status.dart';
import 'package:flutter/material.dart';

class QuestionModel {
  final String id;
  final String title;
  final String type;
  final String assetUrl;

  final QuestionStatus status;
  final int? chosenAnswerIndex;

  final List<AnswerModel> answers;

  QuestionModel(
      {required this.id,
      required this.title,
      required this.type,
      required this.assetUrl,
      required this.answers,
      required this.chosenAnswerIndex,
      required this.status});

  factory QuestionModel.fromApiJson(Map<String, dynamic> json) {
    Iterable answerListJson = jsonDecode(json['answers']);
    List answerList = answerListJson.toList();
    Iterable<AnswerModel> answerMap = answerList.asMap().entries.map((entry) {
      int index = entry.key;
      return AnswerModel.fromApiJson(entry.value, index);
    });

    return QuestionModel(
        id: json['id'],
        title: json['questionTitle'],
        type: json['questionType'],
        assetUrl: json['questionAssetUrl'],
        status: json['status'].toString().questionStatus,
        answers: answerMap.toList(),
        chosenAnswerIndex: json['answer_idx']);
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    Iterable answerListJson = jsonDecode(json['answers']);

    return QuestionModel(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      assetUrl: json['assetUrl'],
      status: json['status'].toString().questionStatus,
      answers: List<AnswerModel>.from(
          answerListJson.map((model) => AnswerModel.fromJson(model))),
      chosenAnswerIndex: json['chosenAnswerIndex'],
    );
  }

  Map<String, dynamic> toJson() {
    String answerJson = jsonEncode(answers);

    return {
      "id": id,
      "title": title,
      "type": type,
      "assetUrl": assetUrl,
      "status": status.string,
      "answers": answerJson,
      'chosenAnswerIndex': chosenAnswerIndex,
    };
  }
}

class AnswerModel {
  final String clientId;
  final int answerIndex;
  final String label;
  final bool isCorrect;

  AnswerModel(
      {required this.clientId,
      required this.answerIndex,
      required this.label,
      required this.isCorrect});

  factory AnswerModel.fromApiJson(Map<String, dynamic> json, int indexInList) {
    return AnswerModel(
      clientId: UniqueKey().toString(),
      answerIndex: indexInList,
      label: json['answerText'],
      isCorrect: json['result'],
    );
  }

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      clientId: json['clientId'],
      answerIndex: json['answerIndex'],
      label: json['label'],
      isCorrect: json['isCorrect'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "clientId": clientId,
      'answerIndex': answerIndex,
      "label": label,
      "isCorrect": isCorrect,
    };
  }
}
