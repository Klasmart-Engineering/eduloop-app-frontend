import 'dart:convert';

import 'package:edu_app/api/api.dart';
import 'package:edu_app/api/models/session_response.dart';
import 'package:edu_app/models/session.dart';
import 'package:edu_app/utils/local_storage_helper.dart';
import 'package:edu_app/constants/storage_keys.dart';

class SessionHelper {
  static Future<SessionModel> startSession(String userId) async {
    SessionResponse response = await EduloopApi.startSession(userId);

    String sessionJson = jsonEncode(response.session);
    String quizJson = jsonEncode(response.quiz);
    LocalStorageHelper.store(keyCurrentSession, sessionJson);
    LocalStorageHelper.store(keyQuiz, quizJson);

    return response.session;
  }

  static Future<SessionModel?> getSessionFromStorage() async {
    String? sessionValue = await LocalStorageHelper.get(keyCurrentSession);

    if (sessionValue == null) {
      return null;
    }

    dynamic sessionJson = jsonDecode(sessionValue);
    return SessionModel.fromJson(sessionJson);
  }
}
