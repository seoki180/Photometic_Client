import 'package:flutter/material.dart';
import 'package:photometic/repositories/user_%20repositories.dart';

class UserProvider extends ChangeNotifier {
  UserRepositories userRepositories;
  Map userCache = {
    "userName": "",
    "Idx": '',
    "profilePhoto": '',
  };
  List userPhoto = [];

  UserProvider({required this.userRepositories}) {
    // getProfile();
  }

  void getProfile() async {
    final res = await userRepositories.getProfile();
    final data = res[0];
    userCache.update("userName", (value) => data["userName"],
        ifAbsent: () => data);
    userCache.update("Idx", (value) => data["Idx"], ifAbsent: () => data);
    print(userCache);
    notifyListeners();
  }

  void getPhotoUrl() async {
    final List? res = await userRepositories.getPhotos(userCache["uniqueId"]);
    if (res != null) {
      userPhoto = res;
      print(userPhoto);
    }
    notifyListeners();
  }
}
