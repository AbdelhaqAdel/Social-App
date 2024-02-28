// import 'package:shared_preferences/shared_preferences.dart';
//
// class CacheHelper
// {
//   static SharedPreferences? sharedPreferences;
//   static init() async
//   {
//     sharedPreferences=await SharedPreferences.getInstance();
//   }
//   // static Future<bool?> putData({
//   //    required String key,
//   //    required bool value,
//   //  }) async
//   //  {
//   //   return await sharedPreferences?.setBool( key , value );
//   //  }
//   //   static bool? getData({
//   //    required String key,
//   //  })
//   //  {
//   //   return sharedPreferences?.getBool( key );
//   //  }
//
//   static Future<bool?> savaData({
//     required String key,
//     required var  value,
//   })async
//   {
//     if(value is String)return await sharedPreferences?.setString(key, value);
//     if(value is int)return await sharedPreferences?.setInt(key, value);
//     if(value is bool)return await sharedPreferences?.setBool(key, value);
//     return await sharedPreferences?.setDouble(key, value);
//   }
//   static dynamic getAllData({
//     required String key,
//   })
//   {
//     return sharedPreferences?.get(key);
//   }
//
//   static Future<bool?> removedata ( {required String key,})async{
//     return await sharedPreferences?.remove(key);
//
//   }
//
// }
//



// import 'package:shared_preferences/shared_preferences.dart';
//
// class CacheHelper {
//   static SharedPreferences? sharedPreferences;
//
//   static Future<void> init() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//   }
//
//   static Future<void> savaData({
//     required String key,
//     required dynamic value,
//   }) async {
//     if (value is String) {
//       await sharedPreferences?.setString(key, value);
//     } else if (value is int) {
//       await sharedPreferences?.setInt(key, value);
//     } else if (value is bool) {
//       await sharedPreferences?.setBool(key, value);
//     } else if (value is double) {
//       await sharedPreferences?.setDouble(key, value);
//     }
//   }
//
//   static dynamic getData(String key) {
//     return sharedPreferences?.get(key);
//   }
// }

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
  static Future<bool?> removedata ( {required String key,})async{
    return await sharedPreferences?.remove(key);
  }
}