import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class SecureCacheHelper {
  SecureCacheHelper._privateConstructor();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static bool _isInitialized = false;

  static Future<void> init() async {
    await _storage.read(key: "_init_test").catchError((e) {
      throw Exception("SecureCacheHelper initialization failed: $e");
    });
    _isInitialized = true;
  }
  static Future<List<String>> getAllKeys() async {
    if (!_isInitialized) {
      throw Exception("SecureCacheHelper not initialized. Call SecureCacheHelper.init() first.");
    }
    final allValues = await _storage.readAll();
    return allValues.keys.toList();
  }
  static Future<void> set({required String key, required String value}) async {
    if (!_isInitialized) throw Exception("SecureCacheHelper not initialized. Call SecureCacheHelper.init() first.");
    await _storage.write(key: key, value: value);
  }

  static Future<String?> getString({required String key}) async {
    if (!_isInitialized) throw Exception("SecureCacheHelper not initialized. Call SecureCacheHelper.init() first.");
    return await _storage.read(key: key);
  }

  static Future<void> remove({required String key}) async {
    if (!_isInitialized) throw Exception("SecureCacheHelper not initialized. Call SecureCacheHelper.init() first.");
    await _storage.delete(key: key);
  }

  static Future<void> clear() async {
    if (!_isInitialized) throw Exception("SecureCacheHelper not initialized. Call SecureCacheHelper.init() first.");
    await _storage.deleteAll();
  }
}