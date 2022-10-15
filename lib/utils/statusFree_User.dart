import 'package:flutter/cupertino.dart';

class StatusFreeUser with ChangeNotifier {
  int statusFreeUser = 0;

  void statusFreelancer() {
    statusFreeUser = 1;
    notifyListeners();
  }

  void statusUser() {
    statusFreeUser = 0;
    notifyListeners();
  }

  int getStatus() => statusFreeUser;
}
