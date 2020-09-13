import 'package:flutter/cupertino.dart';
import 'package:soqya/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel userModel;

  void setUser(UserModel m) {
    userModel = m;
    notifyListeners();
  }
}
