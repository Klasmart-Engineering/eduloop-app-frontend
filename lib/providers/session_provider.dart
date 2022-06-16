import 'package:edu_app/models/question_status.dart';
import 'package:edu_app/models/quiz_session.dart';
import 'package:edu_app/models/session.dart';
import 'package:edu_app/services/quiz_service.dart';
import 'package:edu_app/services/session_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final quizSessionProvider = StateNotifierProvider.autoDispose<
    QuizSessionNotifier,
    AsyncValue<QuizSessionModel?>>((ref) => QuizSessionNotifier());

class QuizSessionNotifier extends StateNotifier<AsyncValue<QuizSessionModel?>> {
  QuizSessionNotifier() : super(const AsyncValue.loading()) {
    init();
  }

  void init() async {
    state = const AsyncValue.loading();
    print('INIT SESSION');
    await AsyncValue.guard(() async {
      return await refetchSession();
    });
  }

  /// Initiates the session in the api and saves logged in session user in localstorage
  Future<SessionModel> pickUpSessionFromStorage() async {
    final SessionModel? quizSession =
        await SessionService.getSessionFromStorage();

    if (quizSession == null) throw Exception('quiz session not in storage');

    return quizSession;
  }

  Future<QuizSessionModel?> startSession(String userId) async {
    try {
      final response = await SessionService.startSession(userId);
      final quizSession = response.quizSession;
      state = AsyncValue.data(quizSession);

      return quizSession;
    } catch (e) {
      state = AsyncValue.error(e);
    }

    return null;
  }

  Future<QuizSessionModel?> refetchSession() async {
    try {
      final response = await SessionService.refetchSession();
      final quizSession = response.quizSession;
      state = AsyncValue.data(quizSession);
      return quizSession;
    } catch (e) {
      state = AsyncValue.error(e);
    }

    return null;
  }

  /// Removes session from state and local storage, sets the state to loading
  /// Typically used to complete the quiz in progress
  Future<void> closeSession() async {
    try {
      QuizSessionModel? quizSession = state.value;
      final SessionModel? storedSession =
          await SessionService.getSessionFromStorage();

      String? userId = quizSession?.session.userId ?? storedSession?.userId;
      String? sessionId = quizSession?.session.id ?? storedSession?.id;

      if (userId == null || sessionId == null) {
        print('error: no session to close');
        throw Exception('no session to close');
      }

      await SessionService.closeSession(userId, sessionId);
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> goToPreviousQuestion() async {
    try {
      final session = state.value?.session;

      if (session == null) {
        throw Exception('no session available');
      }

      QuizSessionModel newQuizSession =
          await QuizService.getPreviousQuestion(session);

      state = AsyncValue.data(newQuizSession);
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> skipQuestion() async {
    try {
      final session = state.value?.session;
      final currentQuizState = state.value?.quiz;

      if (session == null) {
        throw Exception('no session available');
      }

      QuizSessionModel newQuizSession =
          await QuizService.skipQuestion(session, currentQuizState!);

      state = AsyncValue.data(newQuizSession);
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> validateQuestionAnswer(
      int answerIndex, QuestionStatus status) async {
    try {
      final session = state.value?.session;
      final currentQuizState = state.value?.quiz;

      if (session == null) {
        throw Exception('no session available');
      }

      QuizSessionModel newQuizSession =
          await QuizService.validateQuestionAnswer(
              session, status, currentQuizState!, answerIndex);

      state = AsyncValue.data(newQuizSession);
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }
}
