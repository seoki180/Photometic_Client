import 'package:flutter/material.dart';

class RegisterModel extends ChangeNotifier {
  String id = '';
  String name = '';
  String password = '';

  void setId(String id) {
    this.id = id;
  }

  void setName(String name) {
    this.name = name;
  }

  void setPassword(String password) {
    this.password = password;
  }

  String getId() {
    return id;
  }

  String getName() {
    return name;
  }

  String getPassword() {
    return password;
  }

  Map<String, String> toJson() {
    return {
      "id": id,
      "password": password,
      "name": name,
    };
  }
}
