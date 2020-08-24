import 'package:flutter/material.dart';
import 'package:mal/model/mal_account.dart';

class MalAccountProvider with ChangeNotifier {
  MalAccount _account;

  void addAccount(MalAccount account) {
    _account = account;
    notifyListeners();
  }

  void removeAccount() {
    _account = null;
    notifyListeners();
  }

  MalAccount get account => _account;
}
