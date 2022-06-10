import 'package:edu_app/models/session.dart';
import 'package:edu_app/services/session_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final quizSessionProvider =
    StateNotifierProvider<QuizSessionNotifier, AsyncValue<SessionModel>>(
        (ref) => QuizSessionNotifier());

class QuizSessionNotifier extends StateNotifier<AsyncValue<SessionModel>> {
  QuizSessionNotifier() : super(const AsyncValue.loading()) {
    init();
  }

  void init() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      print('New session?');
      return await pickUpSessionFromStorage();
    });
  }

  /// Initiates the session in the api and saves logged in session user in localstorage
  Future<SessionModel> pickUpSessionFromStorage() async {
    final SessionModel? quizSession =
        await SessionService.getSessionFromStorage();

    if (quizSession == null) throw Exception('quiz session not in storage');

    return quizSession;
  }

  /// Removes session from state and local storage, sets the state to loading
  /// Typically used to complete the quiz in progress
  Future<void> closeSession() async {
    try {
      SessionModel? session = state.value;
      final SessionModel? storedSession =
          await SessionService.getSessionFromStorage();

      String? userId = session?.userId ?? storedSession?.userId;
      String? sessionId = session?.id ?? storedSession?.id;

      if (userId == null || sessionId == null) {
        print('error: no session to close');
        throw Exception('no session to close');
      }

      await SessionService.closeSession(userId, sessionId);
    } catch (e) {
      print('in catch: $e');
      state = AsyncValue.error(e);
      print('after state');
    }
  }
}
