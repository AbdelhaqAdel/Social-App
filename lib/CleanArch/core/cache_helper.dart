import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      await sharedPreferences?.setString(key, value);
    } else if (value is int) {
      await sharedPreferences?.setInt(key, value);
    } else if (value is bool) {
      await sharedPreferences?.setBool(key, value);
    } else if (value is double) {
      await sharedPreferences?.setDouble(key, value);
    }
  }

  static dynamic getData(String key) {
    return sharedPreferences?.get(key);
  }
  static Future<bool?> removeData ( {required String key,})async{
    return await sharedPreferences?.remove(key);
  }
}