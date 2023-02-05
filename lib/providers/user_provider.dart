import 'package:amazon_clone/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    phoneNumber: '',
    type: '',
    token: '',
    cart: [],
  );

  User get user => _user;

  Future<void> setUser(String user) async {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }

}
