import 'package:edu_app/api/models/start_session_response.dart';
import 'package:edu_app/models/question.dart';
import 'package:edu_app/models/question_status.dart';
import 'package:edu_app/models/quiz_state.dart';
import 'package:edu_app/providers/session_provider.dart';
import 'package:edu_app/services/quiz_service.dart';
import 'package:edu_app/services/session_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Tracks the state and list of questions received.
class QuizManager {
  late final QuizStateModel state;

  /// Every question received from the api is stored in chronological order
  /// by index to preserve carousel views during navigation.
  late final Map<int, QuestionModel?> questions;

  /// We mark the initial question on initalizations to help the carousel keep track.
  late int initialQuestionNumber;

  QuizManager(QuizStateModel newState) {
    state = newState;
    questions = {newState.currentQuestionNumber: newState.currentQuestion};
    initialQuestionNumber = newState.currentQuestionNumber;
  }

  /// Accepts an existing [QuizManager] and overrites the [state] with the new one
  /// whilst merging question lists together and preserving the [initialQuestionNumber]
  QuizManager.merge(QuizManager peviousManager, newState) {
    final Map<int, QuestionModel?> mergedQuestions = {
      ...peviousManager.questions,
      newState.currentQuestionNumber: newState.currentQuestion
    };

    state = newState;
    questions = mergedQuestions;
    initialQuestionNumber = peviousManager.initialQuestionNumber;
  }
}

final quizManagerProvider = StateNotifierProvider.autoDispose<
    QuizManagerNotifier, AsyncValue<QuizManager>>((ref) {
  return QuizManagerNotifier(ref.read);
});

class QuizManagerNotifier extends StateNotifier<AsyncValue<QuizManager>> {
  QuizManagerNotifier(this.read) : super(const AsyncValue.loading()) {
    init();
  }

  // the ref.read function - source https://riverpod.dev/docs/concepts/combining_providers
  final Reader read;

  void init() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      StartSessionResponse session = await SessionService.refetchSession();
      QuizStateModel quizState = session.quiz;

      print('new state');
      print(session.session.id);

      return updateQuizManager(quizState);
    });
  }

  Future<void> validateQuestionAnswer(
      int answerIndex, QuestionStatus status) async {
    try {
      String sessionToken = await getSessionToken();
      QuizStateModel currentState = getCurrentQuizState();

      QuizStateModel? newQuizState = await QuizService.validateQuestionAnswer(
          sessionToken, status, currentState, answerIndex);

      QuizManager newState = updateQuizManager(newQuizState);
      state = AsyncValue.data(newState);
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> skipQuestion() async {
    try {
      String sessionToken = await getSessionToken();
      QuizStateModel currentState = getCurrentQuizState();

      QuizStateModel newQuizState =
          await QuizService.skipQuestion(sessionToken, currentState);

      QuizManager newState = updateQuizManager(newQuizState);
      state = AsyncValue.data(newState);
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> goToPreviousQuestion() async {
    try {
      String sessionToken = await getSessionToken();
      QuizStateModel newQuizState =
          await QuizService.getPreviousQuestion(sessionToken);

      QuizManager newState = updateQuizManager(newQuizState);
      state = AsyncValue.data(newState);
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  QuizManager updateQuizManager(QuizStateModel newState) {
    final QuizManager? previousManager = state.value;

    if (previousManager != null) {
      return QuizManager.merge(previousManager, newState);
    }

    return QuizManager(newState);
  }

  QuizStateModel getCurrentQuizState() {
    QuizManager? currentManager = state.value;

    if (currentManager == null) {
      throw Exception('No state to get current question');
    }

    return currentManager.state;
  }

  Future<String> getSessionToken() async {
    final session = await read(quizSessionProvider.future);
    return session.id;
  }

  void resetProvider() async {}
}
