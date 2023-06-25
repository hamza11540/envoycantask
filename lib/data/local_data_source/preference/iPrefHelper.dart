

import 'package:shared_preferences/shared_preferences.dart';



abstract class IPrefHelper {
  String? retrieveRefreshToken();
  String? retrieveAccessToken();
  void saveRefreshToken(value);
  void saveAccessToken(value);
  void removeToken();
  SharedPreferences get();
  void clear();


}
