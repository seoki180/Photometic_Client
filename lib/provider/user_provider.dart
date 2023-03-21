import 'package:flutter/material.dart';
import 'package:photometic/repositories/user_%20repositories.dart';

class UserProvider extends ChangeNotifier {
  final UserRepositories userRepositories;
  Map<String, dynamic> userCache = {};

  UserProvider({
    required this.userRepositories,
  }) : super() {
    getProfile();
  }

  void getProfile() async {
    final res = await userRepositories.getProfile();
    userCache.update("userInfo", (value) => res, ifAbsent: () => res);
    notifyListeners();
  }
}
