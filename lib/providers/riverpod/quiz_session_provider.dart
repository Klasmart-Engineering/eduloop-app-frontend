import 'package:edu_app/models/session.dart';
import 'package:edu_app/utils/session_helper.dart';
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
      final SessionModel? quizSession =
          await SessionHelper.getSessionFromStorage();

      if (quizSession == null) throw Exception('quiz session not in storage');

      return quizSession;
    });
  }
}
