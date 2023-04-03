import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  late String id;
  late String password;

  void setId(String id) {
    this.id = id;
  }

  void setPassword(String password) {
    this.password = password;
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
