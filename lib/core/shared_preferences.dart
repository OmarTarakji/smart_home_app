import 'package:shared_preferences/shared_preferences.dart';

class CachedPreferences {
  static final CachedPreferences _instance = CachedPreferences._internal();
  late SharedPreferences _prefs;

  factory CachedPreferences() => _instance;

  CachedPreferences._internal();

  Future<void> init() async => _prefs = await SharedPreferences.getInstance();

  // Get with cache
  dynamic get(String key) => _prefs.get(key);

  // Set with cache
  Future<bool> set(String key, dynamic value) async {
    if (value is String) return _prefs.setString(key, value);
    // if (value is int) return _prefs.setInt(key, value);
    // if (value is double) return _prefs.setDouble(key, value);
    // if (value is bool) return _prefs.setBool(key, value);
    // if (value is List<String>) return _prefs.setStringList(key, value);

    throw Exception('Unsupported type: ${value.runtimeType}');
  }

  Future<bool> remove(String key) async => _prefs.remove(key);

  Future<bool> clear() async => _prefs.clear();
}
