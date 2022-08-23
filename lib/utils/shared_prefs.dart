import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;
  static FlutterSecureStorage? _secureSharedPrefs;
  static const _keyRefreshToken = 'refresh_token';

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  static Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
    _secureSharedPrefs ??= const FlutterSecureStorage();
  }

  //refresh_token
  static Future<void> setRefreshToken({required String refreshToken}) async =>
      await _secureSharedPrefs?.write(
          key: _keyRefreshToken, value: refreshToken);

  static Future<String?> getRefreshToken() async =>
      await _secureSharedPrefs?.read(key: _keyRefreshToken);

  //example shared prefs
  /*static Future<void> setLanguage(String code) async =>
      await _sharedPrefs?.setString(_keyLanguage, code);

  static String? getLanguage() => _sharedPrefs?.getString(_keyLanguage);*/

  //clear storage
  static Future<void> deleteSecureData(String key) async {
    return await _secureSharedPrefs?.delete(key: key);
  }

  static Future<void> deleteAllSecureData() async {
    return await _secureSharedPrefs?.deleteAll();
  }

  static Future<bool?> deleteAllData() async {
    return await _sharedPrefs?.clear();
  }
}