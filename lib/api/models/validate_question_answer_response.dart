// https://stackoverflow.com/questions/53931513/store-data-as-an-object-in-shared-preferences-in-flutter
import 'package:edu_app/models/quiz.dart';

class ValidateQuestionAnswerResponse {
  final QuizStateModel quiz;

  ValidateQuestionAnswerResponse({required this.quiz});

  factory ValidateQuestionAnswerResponse.fromApiJson(
      Map<String, dynamic> json) {
    return ValidateQuestionAnswerResponse(
      quiz: QuizStateModel.fromApiJson(json),
    );
  }
}
