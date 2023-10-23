import 'dart:async' show Future;

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  // static = life cycle linked to the app ,,,, linked to the class وملهوش علاقة باي object
  static Future<SharedPreferences> get _instance async {
    return _prefsInstance ??= await SharedPreferences
        .getInstance(); // لو يساوي null يبقا ساويه الاول وبعدين رجعه
  }

  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static String getString(String key, [String defValue = '']) {
    return _prefsInstance!.getString(key) ?? defValue ;
  }
  // هنا قيمة prefs مش هتبقا null لانو _instance متعينه من قبل ومحتفظة بقيمتها علشان static
  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }


  static bool getBool(String key, [bool defValue = false]) {
    return _prefsInstance!.getBool(key) ?? defValue ;
  }

  // هنا قيمة prefs مش هتبقا null لانو _instance متعينه من قبل ومحتفظة بقيمتها علشان static
  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }
}
