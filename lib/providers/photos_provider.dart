import 'package:flutter/material.dart';
import 'package:photometic/repositories/user_%20repositories.dart';

class PhotosProvider extends ChangeNotifier {
  UserRepositories userRepositories;
  List photoCache = [];

  PhotosProvider({required this.userRepositories}) {
    getPhotoInfo();
  }

  void getPhotoInfo() async {
    // final res = await userRepositories.getPhotoInfo();
    // notifyListeners();
  }
}
