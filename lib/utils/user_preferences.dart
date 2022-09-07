import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyUser = 'user';
  static const myUser = User(
    imagePath: '',
    name: 'Usuario',
    profissao: 'Garoto de Programa',
    about: 'Eu amo viver!!',
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
