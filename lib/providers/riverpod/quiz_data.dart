import 'package:edu_app/api/models/session_response.dart';
import 'package:edu_app/components/quiz/question_options.dart';
import 'package:edu_app/models/question.dart';
import 'package:edu_app/models/question_status.dart';
import 'package:edu_app/models/quiz.dart';
import 'package:edu_app/models/session.dart';
import 'package:edu_app/providers/riverpod/quiz_session_provider.dart';
import 'package:edu_app/utils/quiz_helper.dart';
import 'package:edu_app/utils/session_helper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizData {
  final QuizStateModel quiz;
  final Map<int, QuestionModel?> questions;

  final int initialQuestionNumber;

  QuizData(this.quiz, this.questions, this.initialQuestionNumber);
}

final quizDataProvider =
    StateNotifierProvider<QuizDataNotifier, AsyncValue<QuizData>>(
        (ref) => QuizDataNotifier(ref.read));

class QuizDataNotifier extends StateNotifier<AsyncValue<QuizData>> {
  QuizDataNotifier(this.read) : super(const AsyncValue.loading()) {
    init();
  }

  // the ref.read function - source https://riverpod.dev/docs/concepts/combining_providers
  final Reader read;

  void init() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      SessionResponse session = await SessionHelper.refetchSession();
      QuizStateModel quizState = session.quiz;

      return updateQuizState(quizState);
    });
  }

  Future<void> validateQuestionAnswer(
      int answerIndex, QuestionStatus status) async {
    try {
      String sessionToken = await getSessionToken();
      String currentQuestionId = getCurrentQuestionId();

      QuizStateModel? newQuizState = await QuizHelper.validateQuestionAnswer(
          sessionToken, status, currentQuestionId, answerIndex);

      QuizData newState = updateQuizState(newQuizState);
      state = AsyncValue.data(newState);
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> skipQuestion() async {
    try {
      String sessionToken = await getSessionToken();
      String currentQuestionId = getCurrentQuestionId();

      QuizStateModel newQuizState =
          await QuizHelper.skipQuestion(sessionToken, currentQuestionId);

      QuizData newState = updateQuizState(newQuizState);
      state = AsyncValue.data(newState);
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> goToPreviousQuestion() async {
    try {
      String sessionToken = await getSessionToken();
      QuizStateModel newQuizState =
          await QuizHelper.getPreviousQuestion(sessionToken);

      QuizData newState = updateQuizState(newQuizState);
      state = AsyncValue.data(newState);
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  QuizData updateQuizState(QuizStateModel newState) {
    final QuizData? prevState = state.value;
    final Map<int, QuestionModel?> prevQuestions =
        prevState != null ? prevState.questions : {};
    final int initialQuestionNumber = prevState != null
        ? prevState.initialQuestionNumber
        : newState.currentQuestionNumber;

    final Map<int, QuestionModel?> newQuestions = {
      ...prevQuestions,
      newState.currentQuestionNumber: newState.currentQuestion
    };

    return QuizData(newState, newQuestions, initialQuestionNumber);
  }

  String getCurrentQuestionId() {
    QuizData? currentState = state.value;

    if (currentState == null) {
      throw Exception('No state to get current question');
    }

    return currentState.quiz.currentQuestion.id;
  }

  Future<String> getSessionToken() async {
    final session = await read(quizSessionProvider.future);
    return session.id;
  }
}
