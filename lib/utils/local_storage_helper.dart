import 'dart:convert';

import 'package:edu_app/api/api.dart';
import 'package:edu_app/api/models/session_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edu_app/constants/storage_keys.dart';

class LocalStorageHelper {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static void store(String key, String value) async {
    final p = await prefs;
    p.setString(key, value);
  }

  static Future<String?> get(String key) async {
    final p = await prefs;
    return p.getString(key);
  }
}
