import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _keyUid = 'user_uid';

  static Future<String?> getUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUid);
  }

  static Future<void> setUid(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUid, uid);
  }
}