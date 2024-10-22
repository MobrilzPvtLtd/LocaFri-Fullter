import 'package:carapp/utils/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{

  static late final SharedPreferences _preferences;

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future<void> setContractId(int id) async => await _preferences.setInt(SharedPrefsKey.contractId, id);

  static int get getContractId => _preferences.getInt(SharedPrefsKey.contractId) ?? 0;

}