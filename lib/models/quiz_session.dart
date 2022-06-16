import 'package:edu_app/models/quiz_state.dart';
import 'package:edu_app/models/session.dart';

class QuizSessionModel {
  final SessionModel session;
  final QuizStateModel quiz;

  QuizSessionModel({required this.session, required this.quiz});

  factory QuizSessionModel.fromApiJson(Map<String, dynamic> json) {
    return QuizSessionModel(
      session: SessionModel.fromApiJson(json),
      quiz: QuizStateModel.fromApiJson(json),
    );
  }
}
