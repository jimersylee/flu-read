
import 'package:flutter/material.dart';
import 'package:flu-read/shop/models/user_entity.dart';

class UserProvider extends ChangeNotifier {

  UserEntity _user;
  UserEntity get user => _user;
  
  void setUser(UserEntity user) {
    _user = user;
    notifyListeners();
  }
}