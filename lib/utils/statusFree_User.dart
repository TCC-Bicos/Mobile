import 'package:shared_preferences/shared_preferences.dart';

class StatusFreeUser {
  static late SharedPreferences sharedPreferences;

  static const _keyStatus = 'status';
  static const myStatus = 0;

  static Future init() async =>
      sharedPreferences = await SharedPreferences.getInstance();

  static Future setStatus(int status) async {
    await sharedPreferences.setInt(_keyStatus, status);
  }

  static int getStatus() {
    final status = sharedPreferences.getInt(_keyStatus);
    return status ?? myStatus;
  }
}
