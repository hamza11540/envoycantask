import 'dart:convert';


import 'package:shared_preferences/shared_preferences.dart';

import 'iPrefHelper.dart';

class PrefHelper implements IPrefHelper {
  late final SharedPreferences _pref;

  PrefHelper(SharedPreferences preferences) : _pref = preferences;

  @override
  void clear() {
    _pref.clear();
  }

  @override
  SharedPreferences get() {
    return _pref;
  }

  @override
  void removeToken() {
    _pref.remove('userToken');
  }


  @override
  String? retrieveAccessToken() {
    if (_pref.containsKey("userAccessToken")) {
      return _pref.getString("userAccessToken");
    } else {
      return null;
    }
  }

  @override
  String? retrieveRefreshToken() {
    if (_pref.containsKey("userRefreshToken")) {
      return _pref.getString("userRefreshToken");
    } else {
      return null;
    }
  }

  @override
  void saveAccessToken(value) {
    _pref.setString("userAccessToken", value);
  }

  @override
  void saveRefreshToken(value) {
    _pref.setString("userRefreshToken", value);
  }
}
