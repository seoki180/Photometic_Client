import 'package:flutter/material.dart';
import 'package:photometic/repositories/user_%20repositories.dart';

class UserProvider extends ChangeNotifier {
  UserRepositories userRepositories;
  Map userCache = {};

  UserProvider({required this.userRepositories}) {
    getProfile();
  }

  void getProfile() async {
    final res = await userRepositories.getProfile();
    userCache.update("name", (value) => res, ifAbsent: () => res);
    notifyListeners();
  }
}
