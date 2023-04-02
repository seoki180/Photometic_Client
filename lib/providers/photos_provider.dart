import 'package:flutter/material.dart';
import 'package:photometic/repositories/user_%20repositories.dart';

class PhotosProvider extends ChangeNotifier {
  UserRepositories userRepositories;
  Map photoCache = {};

  PhotosProvider({required this.userRepositories}) {
    // getPhotos();
  }

  void getPhotos() async {
    final res = await userRepositories.getPhotos();
    for (Map value in res) {
      print("$value \n");
      photoCache.update("photo", (value) => value, ifAbsent: () => null);
    }
    notifyListeners();
    // final userData = res["userData"];
    // final userPhotos = res["userPhotos"];

    // userCache.update("photos", (value) => userPhotos, ifAbsent: () => res);
    // notifyListeners();
  }
}
