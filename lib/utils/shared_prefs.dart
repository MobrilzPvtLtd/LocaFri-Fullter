import 'package:carapp/utils/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future<void> setContractId(int id) async =>
      await _preferences.setInt(SharedPrefsKey.contractId, id);
  static Future<void> setUserEmail(String email) async =>
      await _preferences.setString(SharedPrefsKey.userEmail, email);
  static Future<void> setUserFirstName(String firstName) async =>
      await _preferences.setString(SharedPrefsKey.userFirstName, firstName);
  static Future<void> setUserLastName(String lastName) async =>
      await _preferences.setString(SharedPrefsKey.userLastName, lastName);
  static Future<void> setUserPhoneNumber(String phoneNumber) async =>
      await _preferences.setString(SharedPrefsKey.userPhoneNumber, phoneNumber);
  static Future<void> setToken(String token) async =>
      await _preferences.setString(SharedPrefsKey.token, token);

  static int get getContractId =>
      _preferences.getInt(SharedPrefsKey.contractId) ?? 0;
  static String get getUserEmail =>
      _preferences.getString(SharedPrefsKey.userEmail) ?? "";
  static String get getUserFisrtName =>
      _preferences.getString(SharedPrefsKey.userFirstName) ?? "";
  static String get getUserLastName =>
      _preferences.getString(SharedPrefsKey.userLastName) ?? "";
  static String get getUserPhoneNumber =>
      _preferences.getString(SharedPrefsKey.userPhoneNumber) ?? "";
  static String get getToken =>
      _preferences.getString(SharedPrefsKey.token) ?? "";

  static Future<void> resetValue(String key) async {
    await _preferences.remove(key);
  }
}
