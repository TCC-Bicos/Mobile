import 'package:bicos_app/utils/statusFree_User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemaApp with ChangeNotifier {
  late SharedPreferences _preferences;

  int temaClaroEscuro = 0;

  Color get getPrimaryColorUser => Colors.blue;
  Color get getPrimaryColorFree => Colors.green;

  Color get getSecundaryColorUser => (Colors.blue[800])!;
  Color get getSecundaryColorFree => (Colors.green[800])!;

  Color get getBackgroundColorUser => temaClaroEscuro == 0
      ? const Color.fromARGB(255, 250, 253, 255)
      : const Color.fromARGB(255, 30, 30, 30);

  Color get getBackgroundColorFree => temaClaroEscuro == 0
      ? const Color.fromARGB(255, 250, 253, 255)
      : const Color.fromARGB(255, 30, 30, 30);

  Color get getBackgroundColor => temaClaroEscuro == 0
      ? const Color.fromARGB(255, 250, 253, 255)
      : const Color.fromARGB(255, 30, 30, 30);

  Color get getDarkBackgroundColor => temaClaroEscuro == 0
      ? const Color.fromARGB(100, 203, 205, 207)
      : const Color.fromARGB(220, 24, 25, 28);

  Color get getTextColorUser => temaClaroEscuro == 0
      ? const Color.fromARGB(255, 0, 38, 92)
      : (Colors.blueGrey[100])!;

  Color get getTextColorFree => temaClaroEscuro == 0
      ? const Color.fromARGB(255, 0, 59, 3)
      : (Colors.blueGrey[100])!;

  Color get getSecundaryTextColor =>
      temaClaroEscuro == 0 ? (Colors.blueGrey[800])! : (Colors.blueGrey[300])!;

  int get getTemaClaroEscuro => temaClaroEscuro;

  void temaClaro() {
    temaClaroEscuro = 0;
    notifyListeners();
  }

  void temaEscuro() {
    temaClaroEscuro = 1;
    notifyListeners();
  }

  TemaApp() {
    _startSettings();
  }

  _startSettings() async {
    await _startPreferences();
    await _readTheme();
  }

  Future<void> _startPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  _readTheme() {
    final tema = _preferences.getInt('tema') ?? 0;
    temaClaroEscuro = tema;
    notifyListeners();
  }

  setTheme(int tema) async {
    await _preferences.setInt('tema', tema);
    await _readTheme();
  }
}
