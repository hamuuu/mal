import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth with ChangeNotifier {
  GoogleSignInAccount _account;
  GoogleSignIn _googleSignIn;

  void addAccount(GoogleSignInAccount account, GoogleSignIn googleSignIn) {
    _account = account;
    _googleSignIn = googleSignIn;
    notifyListeners();
  }

  void removeAccount() {
    _account = null;
    notifyListeners();
  }

  GoogleSignInAccount get account => _account;
  GoogleSignIn get googleSignIn => _googleSignIn;
}
