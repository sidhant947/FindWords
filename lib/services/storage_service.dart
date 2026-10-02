import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _keyHighLevel = 'high_level';
  static const String _keyHaptic = 'haptic_enabled';
  static const String _keyTheme = 'theme_id';

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static int getHighestLevel() {
    return _prefs.getInt(_keyHighLevel) ?? 1;
  }

  static Future<void> setHighestLevel(int level) async {
    if (level > getHighestLevel()) {
      await _prefs.setInt(_keyHighLevel, level);
    }
  }

  static bool getHapticEnabled() {
    return _prefs.getBool(_keyHaptic) ?? true;
  }

  static Future<void> setHapticEnabled(bool value) async {
    await _prefs.setBool(_keyHaptic, value);
  }

  static String getThemeId() {
    return _prefs.getString(_keyTheme) ?? 'clean';
  }

  static Future<void> setThemeId(String themeId) async {
    await _prefs.setString(_keyTheme, themeId);
  }
}
