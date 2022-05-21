import 'package:edu_app/models/question.dart';

class QuizStateModel {
  final int questionSentUTC;
  final int currentQuestionNumber;
  final int totalNumberOfQuestions;
  final QuestionModel currentQuestion;
  final int earnedScore;

  QuizStateModel(
      {required this.currentQuestionNumber,
      required this.questionSentUTC,
      required this.totalNumberOfQuestions,
      required this.earnedScore,
      required this.currentQuestion});

  factory QuizStateModel.fromApiJson(Map<String, dynamic> json) {
    return QuizStateModel(
      currentQuestionNumber: json['currpos'],
      totalNumberOfQuestions: json['total_num_of_questions'],
      questionSentUTC: json['question_sent_utc'],
      earnedScore: json['earned_score'],
      currentQuestion: QuestionModel.fromApiJson(json['question']),
    );
  }

  factory QuizStateModel.fromJson(Map<String, dynamic> json) {
    return QuizStateModel(
      currentQuestionNumber: json['currentQuestionNumber'],
      questionSentUTC: json['questionSentUTC'],
      totalNumberOfQuestions: json['totalNumberOfQuestions'],
      earnedScore: json['earnedScore'],
      currentQuestion: QuestionModel.fromJson(json['currentQuestion']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "currentQuestionNumber": currentQuestionNumber,
      "questionSentUTC": questionSentUTC,
      "totalNumberOfQuestions": totalNumberOfQuestions,
      "earnedScore": earnedScore,
      "currentQuestion": currentQuestion.toJson(),
    };
  }
}
