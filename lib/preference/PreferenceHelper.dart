import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String USER_CREDENTIAL = "reg";
  static const String IS_LOGGED_IN = "is_loggedin";

  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  bool isLoggedIn() {
    return _preferences.getBool(IS_LOGGED_IN);
  }

  void setLogin(bool isLoggedIn) {
    _saveToDisk(IS_LOGGED_IN, isLoggedIn);
  }

  dynamic getFromDisk(String key) {
    var value = _preferences.get(key);
    return value;
  }

  void saveUserRegCred(String cred){
    _saveToDisk(USER_CREDENTIAL, cred);
  }


  // updated _saveToDisk function that handles all types
  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
    if (content == null) {
      _preferences.setString(key, null);
    }
  }

  void clearFromDisk(String prefKey) {
    _preferences.remove(prefKey);
  }

  Stream<String> onLogout() {
    return logoutEvents.stream;
  }

  var logoutEvents = new StreamController<String>();

  void setKey(String key, String token) {
    _saveToDisk(key, token);
  }

  String getKey(String key) {
    return _preferences.get(key);
  }

  void clear(){
    _preferences.clear();
  }

}
