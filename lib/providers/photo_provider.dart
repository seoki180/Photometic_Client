import 'package:flutter/material.dart';
import 'package:photometic/repositories/user_%20repositories.dart';

class PhotoProvider extends ChangeNotifier {
  UserRepositories userRepositories;
  List photoCache = [];
  List photoUrl = [];

  PhotoProvider({required this.userRepositories});

  Future getPhotoInfo() async {
    final res = await userRepositories.getPhotoInfo();
    if (res != null) {
      res.forEach(
        (url) => {photoCache.add(url)},
      );
      notifyListeners();

      print(photoCache);
      return photoCache;
    }
    return "no";
  }
}
