import 'package:edu_app/models/question.dart';

class QuizStateModel {
  final int questionSentUTC;
  final int currentQuestionNumber;
  final int totalNumberOfQuestions;
  final QuestionModel currentQuestion;
  final int earnedScore;
  final bool noMoreQuestions;
  final bool hasNextQuestion;

  QuizStateModel(
      {required this.currentQuestionNumber,
      required this.questionSentUTC,
      required this.totalNumberOfQuestions,
      required this.earnedScore,
      required this.currentQuestion,
      required this.noMoreQuestions,
      required this.hasNextQuestion});

  factory QuizStateModel.fromApiJson(Map<String, dynamic> json) {
    final int indexToPageNumber = json['currpos'] + 1;

    return QuizStateModel(
      currentQuestionNumber: indexToPageNumber,
      totalNumberOfQuestions: json['total_num_of_questions'],
      questionSentUTC: json['question_sent_utc'],
      earnedScore: json['earned_score'],
      noMoreQuestions: json['no_more_questions'] ?? false,
      hasNextQuestion: json['has_next_question'] ?? true,
      currentQuestion: QuestionModel.fromApiJson(json['question']),
    );
  }
}
