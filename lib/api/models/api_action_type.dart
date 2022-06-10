/// Each action type is passed as a string to detemine the function used in the api
enum ApiActionType {
  startSession,
  closeSession,
  previousQuestion,
  validateQuestionResponse
}

extension ApiActionTypeString on String {
  ApiActionType get apiActionType {
    switch (this) {
      case 'start_session':
        return ApiActionType.startSession;
      case 'confirm_session':
        return ApiActionType.closeSession;
      case 'previous_question':
        return ApiActionType.previousQuestion;
      case 'question_response':
        return ApiActionType.validateQuestionResponse;
    }

    throw Exception('Question Status not recognised');
  }
}

extension ApiActionTypeExtension on ApiActionType {
  String get string {
    switch (this) {
      case ApiActionType.startSession:
        return 'start_session';
      case ApiActionType.closeSession:
        return 'confirm_session';
      case ApiActionType.previousQuestion:
        return 'previous_question';
      case ApiActionType.validateQuestionResponse:
        return 'question_response';
    }
  }
}
