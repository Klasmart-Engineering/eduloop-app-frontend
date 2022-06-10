import 'dart:convert';

import 'package:edu_app/api/api.dart';
import 'package:edu_app/api/models/base_response.dart';
import 'package:edu_app/api/models/start_session_response.dart';
import 'package:edu_app/models/session.dart';
import 'package:edu_app/services/local_storage_service.dart';
import 'package:edu_app/constants/storage_keys.dart';

class SessionService {
  /// Initiates the session from the api and stores the ids in local storage to refetch it in future
  static Future<StartSessionResponse> startSession(String userId) async {
    StartSessionResponse response = await EduloopApi.startSession(userId);

    String sessionJson = jsonEncode(response.session);

    LocalStorageService.store(keyCurrentSession, sessionJson);
    return response;
  }

  static Future<BaseResponse> closeSession(
      String userId, String sessionId) async {
    BaseResponse response = await EduloopApi.closeSession(userId, sessionId);

    LocalStorageService.removeKey(keyCurrentSession);
    return response;
  }

  static Future<SessionModel> getSessionFromStorage() async {
    String? sessionValue = await LocalStorageService.get(keyCurrentSession);

    if (sessionValue == null) {
      throw Exception('No session in storage');
    }

    dynamic sessionJson = jsonDecode(sessionValue);
    return SessionModel.fromJson(sessionJson);
  }

  /// Retrieves the session user id from local storage to refetch state information from api
  static Future<StartSessionResponse> refetchSession() async {
    SessionModel session = await getSessionFromStorage();

    return startSession(session.userId);
  }
}
