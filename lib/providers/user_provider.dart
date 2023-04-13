import 'package:flutter/material.dart';
import 'package:photometic/repositories/user_%20repositories.dart';

class UserProvider extends ChangeNotifier {
  // UserRepositories userRepositories;
  Map userCache = {
    "userName": " ",
    "Idx": ' ',
    "userProfile": ' ',
  };

  UserProvider() {
    getProfile();
  }

  void getProfile() async {
    var userRepositories = UserRepositories();
    final res = await userRepositories.getProfile();
    final data = res[0];
    userCache.update("userName", (value) => data["userName"],
        ifAbsent: () => null);
    userCache.update("Idx", (value) => data["Idx"], ifAbsent: () => null);
    userCache.update("userProfile", (value) => data["userProfile"],
        ifAbsent: () => null);

    print(userCache);
    notifyListeners();
  }

  // void getPhotoUrl() async {
  //   final List? res = await userRepositories.getPhotos(userCache["uniqueId"]);
  //   if (res != null) {
  //     userPhoto = res;
  //     print(userPhoto);
  //   }
  //   notifyListeners();
  // }
}
