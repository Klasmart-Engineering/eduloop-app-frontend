import 'dart:convert';

import 'package:edu_app/api/api.dart';
import 'package:edu_app/api/models/session_response.dart';
import 'package:edu_app/models/session.dart';
import 'package:edu_app/utils/local_storage_helper.dart';
import 'package:edu_app/constants/storage_keys.dart';

class SessionHelper {
  static Future<SessionResponse> startSession(String userId) async {
    SessionResponse response = await EduloopApi.startSession(userId);

    String sessionJson = jsonEncode(response.session);

    LocalStorageHelper.store(keyCurrentSession, sessionJson);
    return response;
  }

  static Future<SessionModel> getSessionFromStorage() async {
    String? sessionValue = await LocalStorageHelper.get(keyCurrentSession);

    if (sessionValue == null) {
      throw Exception('No session in storage');
    }

    print('session val ${sessionValue}');

    dynamic sessionJson = jsonDecode(sessionValue);
    return SessionModel.fromJson(sessionJson);
  }

  // A combination of both functions, this can be used to refresh the session from the server
  static Future<SessionResponse> refetchSession() async {
    SessionModel session = await getSessionFromStorage();

    return startSession(session.userId);
  }
}
