import 'package:flutter/material.dart';
import 'package:photometic/repositories/user_%20repositories.dart';

class UserProvider extends ChangeNotifier {
  UserRepositories userRepositories;
  Map userCache = {
    "name": '',
    "id": '',
  };
  List userPhoto = [];

  UserProvider({required this.userRepositories}) {
    getProfile();
  }

  void getProfile() async {
    final res = await userRepositories.getProfile();
    userCache.update("name", (value) => res["userName"], ifAbsent: () => res);
    userCache.update("id", (value) => res["id"], ifAbsent: () => res);
    print(userCache);
    notifyListeners();
  }

  void getPhotoUrl() async {
    final List? res = await userRepositories.getPhotos(userCache["id"]);
    if (res != null) {
      userPhoto = res;
      print(userPhoto);
    }
    notifyListeners();
  }
}
