import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  CacheHelper._privateConstructor();

  static late SharedPreferences _prefs;
  static bool _isInitialized = false;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  static Future<void> set({required String key, required dynamic value}) async {
    if (!_isInitialized) throw Exception("CacheHelper not initialized. Call CacheHelper.init() first.");
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    } else {
      throw UnsupportedError('Unsupported value type');
    }
  }
  static Set<String> getKeys() {
    if (!_isInitialized) throw Exception("CacheHelper not initialized. Call CacheHelper.init() first.");
    return _prefs.getKeys();
  }
  static String? getString({required String key}) {
    if (!_isInitialized) throw Exception("CacheHelper not initialized. Call CacheHelper.init() first.");
    return _prefs.getString(key);
  }

  static int? getInt({required String key}) {
    if (!_isInitialized) throw Exception("CacheHelper not initialized. Call CacheHelper.init() first.");
    return _prefs.getInt(key);
  }

  static double? getDouble({required String key}) {
    if (!_isInitialized) throw Exception("CacheHelper not initialized. Call CacheHelper.init() first.");
    return _prefs.getDouble(key);
  }

  static bool? getBool({required String key}) {
    if (!_isInitialized) throw Exception("CacheHelper not initialized. Call CacheHelper.init() first.");
    return _prefs.getBool(key) ?? false;
  }

  static List<String>? getStringList({required String key}) {
    if (!_isInitialized) throw Exception("CacheHelper not initialized. Call CacheHelper.init() first.");
    return _prefs.getStringList(key);
  }

  static Future<bool> remove({required String key}) async {
    if (!_isInitialized) throw Exception("CacheHelper not initialized. Call CacheHelper.init() first.");
    return await _prefs.remove(key);
  }

  static Future<bool> clear() async {
    if (!_isInitialized) throw Exception("CacheHelper not initialized. Call CacheHelper.init() first.");
    return await _prefs.clear();
  }
}