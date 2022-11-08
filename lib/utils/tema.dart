import 'package:bicos_app/utils/statusFree_User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TemaApp with ChangeNotifier {
  int temaClaroEscuro = 0;

  Color get getPrimaryColorUser => Colors.blue;
  Color get getPrimaryColorFree => Colors.green;

  Color get getBackgroundColor => temaClaroEscuro == 0
      ? const Color.fromARGB(255, 250, 253, 255)
      : const Color.fromARGB(255, 2, 21, 37);

  int get getTemaClaroEscuro => temaClaroEscuro;

  void temaClaro() {
    temaClaroEscuro = 0;
    notifyListeners();
  }

  void temaEscuro() {
    temaClaroEscuro = 1;
    notifyListeners();
  }
}
