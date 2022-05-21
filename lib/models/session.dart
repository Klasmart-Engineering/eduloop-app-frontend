// https://stackoverflow.com/questions/53931513/store-data-as-an-object-in-shared-preferences-in-flutter
import 'package:flutter/material.dart';

import 'question.dart';

class SessionModel {
  late final String id;
  final String userId;
  final bool newSession;

  SessionModel(
      {required this.id, required this.userId, required this.newSession});

  factory SessionModel.fromApiJson(Map<String, dynamic> parsedJson) {
    return SessionModel(
        id: parsedJson['sid'],
        userId: parsedJson['uid'],
        newSession: parsedJson['new_session']);
  }

  factory SessionModel.fromJson(Map<String, dynamic> parsedJson) {
    return SessionModel(
        id: parsedJson['id'],
        userId: parsedJson['userId'],
        newSession: parsedJson['newSession']);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "userId": userId, 'newSession': newSession};
  }
}
