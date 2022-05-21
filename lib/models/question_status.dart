// fresh = new, unable to use new as reserved word
enum QuestionStatus { fresh, successful, failed, skipped }

extension QuestionStatusString on String {
  QuestionStatus get questionStatus {
    switch (this) {
      case 'new':
        return QuestionStatus.fresh;
      case 'skipped':
        return QuestionStatus.skipped;
      case 'successful':
        return QuestionStatus.successful;
      case 'failed':
        return QuestionStatus.failed;
    }

    throw Exception('Question Status not recognised');
  }
}

extension QuestionStatusExtension on QuestionStatus {
  String get string {
    switch (this) {
      case QuestionStatus.fresh:
        return 'new';
      case QuestionStatus.skipped:
        return 'skipped';
      case QuestionStatus.successful:
        return 'successful';
      case QuestionStatus.failed:
        return 'failed';
    }
  }
}
