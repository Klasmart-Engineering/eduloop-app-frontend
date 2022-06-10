// https://stackoverflow.com/questions/53931513/store-data-as-an-object-in-shared-preferences-in-flutter
import 'package:edu_app/api/models/base_response.dart';
import 'package:edu_app/models/quiz_state.dart';

class ValidateQuestionAnswerResponse extends BaseResponse {
  final QuizStateModel quiz;

  ValidateQuestionAnswerResponse(
      {required this.quiz, required successful, errmsg})
      : super(successful: successful, errmsg: errmsg);

  factory ValidateQuestionAnswerResponse.fromApiJson(
      Map<String, dynamic> json) {
    return ValidateQuestionAnswerResponse(
      quiz: QuizStateModel.fromApiJson(json),
      successful: json['successful'],
      errmsg: json['errmsg'],
    );
  }
}
