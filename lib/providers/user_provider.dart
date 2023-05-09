import 'package:flutter/material.dart';
import 'package:photometic/repositories/user_repositories.dart';

class UserProvider extends ChangeNotifier {
  bool isLogin = false;
  UserRepositories userRepositories;
  Map userCache = {
    "userName": " ",
    "Idx": ' ',
    "userProfile": ' ',
  };

  UserProvider({
    required this.userRepositories,
  }) : super() {
    getProfile();
  }

  void setLogin() {
    isLogin = true;
    notifyListeners();
  }

  Future getProfile() async {
    final res = await userRepositories.getInfo();
    if (!res["isSuccess"]) {
      return;
    }
    final data = res["result"][0];
    userCache.update("userName", (value) => data["userName"],
        ifAbsent: () => ' ');
    userCache.update("Idx", (value) => data["Idx"], ifAbsent: () => " ");
    userCache.update("userProfile", (value) => data["userProfile"],
        ifAbsent: () => ' ');
    notifyListeners();
    print(userCache);
  }

  void setLogout() {
    isLogin = false;
    userCache.clear();
    notifyListeners();
  }
}
