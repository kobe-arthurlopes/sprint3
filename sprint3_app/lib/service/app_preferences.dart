import 'package:shared_preferences/shared_preferences.dart';

class Preference<T> {
  final String key;
  final T defaultValue;

  const Preference(this.key, this.defaultValue);

  Future<T> get() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get(key);
    return (value is T) ? value : defaultValue;
  }

  Future<void> set(T value) async {
    final prefs = await SharedPreferences.getInstance();

    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else { 
      throw UnsupportedError('Unsupported type for SharedPreferences');
    }
  }
}

class AppPreferences {
  static final isFirstEntry = Preference<bool>('isFirstEntry', true);
}