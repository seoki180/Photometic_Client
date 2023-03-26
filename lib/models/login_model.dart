import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  String id = '';
  String password = '';

  void setId(String id) {
    this.id = id;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  String getId() {
    return id;
  }

  String getPassword() {
    return password;
  }

  Map<String, String> toJson() {
    return {
      "id": id,
      "password": password,
    };
  }
}
