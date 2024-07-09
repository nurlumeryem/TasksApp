import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_app/core/constants/shared_strings.dart';
// Adjust this import based on your project structure

class PreferenceUtils {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences?> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<bool> setBool(String key, bool value) async =>
      await _prefs!.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async =>
      await _prefs!.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async =>
      await _prefs!.setInt(key, value);

  static Future<bool> setString(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setStringList(String key, List<String> value) async =>
      await _prefs!.setStringList(key, value);

  static bool? getBool(String key, {bool? defValue}) =>
      _prefs!.getBool(key) ?? defValue;

  static double? getDouble(String key) => _prefs!.getDouble(key);

  static int? getInt(String key) => _prefs!.getInt(key);

  static String? getString(String key) => _prefs!.getString(key);

  static List<String>? getStringList(String key) => _prefs!.getStringList(key);

  static Future<bool> remove(String key) async => await _prefs!.remove(key);

  static Future<bool> clear() async => await _prefs!.clear();

  // Özel metotlar email, password, name için
  static Future<bool> setEmail(String email) async =>
      await _prefs!.setString(SharedStrings.email, email);

  static String? getEmail() => _prefs!.getString(SharedStrings.email);

  static Future<bool> setPassword(String password) async =>
      await _prefs!.setString(SharedStrings.password, password);

  static String? getPassword() => _prefs!.getString(SharedStrings.password);

  static Future<bool> setName(String name) async =>
      await _prefs!.setString(SharedStrings.name, name);

  static String? getName() => _prefs!.getString(SharedStrings.name);
}
