import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static void store(String key, String value) async {
    final p = await prefs;
    p.setString(key, value);
  }

  static void removeKey(String key) async {
    final p = await prefs;
    p.remove(key);
  }

  static Future<String?> get(String key) async {
    final p = await prefs;
    return p.getString(key);
  }
}
