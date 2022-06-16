import 'package:edu_app/components/quiz/quiz_app_bar.dart';
import 'package:edu_app/components/quiz/quiz_carousel.dart';
import 'package:edu_app/models/quiz_session.dart';
import 'package:edu_app/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizScreen extends ConsumerWidget {
  static const routeName = 'quiz';

  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<QuizSessionModel?> _quizSession =
        ref.watch(quizSessionProvider);

    return Scaffold(
        body: _quizSession.when(
            data: (QuizSessionModel? quizSession) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    QuizAppBar(),
                    Expanded(
                      child: QuizCarousel(),
                    )
                  ]);

              // return Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [Text('session: ${quizSession.session.id}')]);
            },
            error: (err, stack) => Center(child: Text('$err')),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
