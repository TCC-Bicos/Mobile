import 'package:bicos_app/utils/statusFree_User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TemaApp with ChangeNotifier {
  int temaClaroEscuro = 0;

  Color get getPrimaryColorUser => Colors.blue;

  Color get getPrimaryColorFree => Colors.green;

  void temaClaro() {
    temaClaroEscuro = 0;
    notifyListeners();
  }

  void temaEscuro() {
    temaClaroEscuro = 1;
    notifyListeners();
  }
}
