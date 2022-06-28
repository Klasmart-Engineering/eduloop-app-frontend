import 'package:edu_app/app_config.dart';
import 'package:edu_app/eduloop_quiz_app.dart';
import 'package:flutter/material.dart';

void main() {
  const configuredApp = AppConfig(
    child: EduloopQuizApp(),
    environment: Environment.dev,
    appTitle: '[DEV] Eduloop Quiz',
    apiEndpoint:
        'https://8e60boe77b.execute-api.ap-northeast-2.amazonaws.com/question-manager',
  );
  // 4
  runApp(configuredApp);
}
