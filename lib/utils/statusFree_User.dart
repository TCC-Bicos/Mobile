import 'package:flutter/cupertino.dart';

class StatusFreeUser with ChangeNotifier {
  int _statusFreeUser = 0;

  int get getStatus => _statusFreeUser;

  void statusFreelancer() {
    _statusFreeUser = 1;
    notifyListeners();
  }

  void statusUser() {
    _statusFreeUser = 0;
    notifyListeners();
  }
}
