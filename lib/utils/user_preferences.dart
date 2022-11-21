import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/cliente.dart';

class UserPreferences {
  static late SharedPreferences sharedPreferences;

  static const _keyUser = 'user';
  static const myUser = User(
    idUser: 0,
    NomeUser: 'NomeUser',
    CPFUser: 'CPFUser',
    EmailUser: 'EmailUser',
    TelUser: 'TelUser',
    DataNascUser: 'DataNascUser',
    GeneroUser: 'GeneroUser',
    SenhaUser: 'SenhaUser',
    DescUser: 'DescUser',
    ImgUser: '',
    StatusUser: '1',
  );

  static Future init() async =>
      sharedPreferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await sharedPreferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = sharedPreferences.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }

  static Future deslogar() async {
    final json = jsonEncode(myUser.toJson());

    await sharedPreferences.setString(_keyUser, json);
  }
}
