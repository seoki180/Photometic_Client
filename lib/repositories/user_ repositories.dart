import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:photometic/constant/api_constant.dart';
import 'package:photometic/models/login_model.dart';
import 'package:photometic/models/register_model.dart';

class UserRepositories {
  static const storage = FlutterSecureStorage();

  Future Register({required RegisterModel registerModel}) async {
    String url = "$BaseUrl/auth/register";
    final registerModelToJson = registerModel.toJson();

    try {
      final Response response =
          await http.post(Uri.parse(url), body: registerModelToJson);
      final res = json.decode(response.body);
      return res;
    } catch (err) {
      return {
        "code": 500,
        "msg": "$err",
      };
    }
  }

  Future Login({required LoginModel loginModel}) async {
    String url = "$BaseUrl/auth/login";
    final loginModelToJson = loginModel.toJson();

    try {
      final Response response =
          await http.post(Uri.parse(url), body: loginModelToJson);
      final res = json.decode(response.body);

      if (response.statusCode == 200) {
        await storage.write(
          key: "token",
          value: res["result"]["access"],
        );
        return res;
      }
    } catch (err) {
      return {
        "code": 500,
        "success": false,
        "msg": err,
      };
    }
  }

  Future getPhotoInfo() async {
    String url = "$BaseUrl/users/photos";
    String? token = await storage.read(key: "token");

    try {
      final Response response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: token!},
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return (data);
      }
    } catch (err) {
      print(err);
    }
  }

  Future getPhotos(userId) async {
    String url = "$LocalUrl/id/$userId";
    String? token = await storage.read(key: "token");

    try {
      final Response response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: token!},
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
      } else {
        print("no");
      }
    } catch (err) {
      print(err);
    }
  }

  Future getInfo() async {
    String url = "$BaseUrl/user/info";
    String? token = await storage.read(key: "token");

    try {
      final Response response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: token!},
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data["result"];
      } else {
        return '';
      }
    } catch (err) {
      return '';
    }
  }

  Future changeProfile(photo) async {
    String url = "$BaseUrl/user/profile";
    String? token = await storage.read(key: "token");

    var request = http.MultipartRequest('POST', Uri.parse(url));
    var image = await http.MultipartFile.fromPath('img', photo.path);
    request.files.add(image);
    request.headers.addAll({'Authorization': token!});
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully!');
    } else {
      print('Error uploading image. Status code: ${response.statusCode}');
    }
  }

  Future uploadPhoto({required File photo}) async {
    String url = "$BaseUrl/user/upload";
    String? token = await storage.read(key: "token");

    var request = http.MultipartRequest('POST', Uri.parse(url));
    var image = await http.MultipartFile.fromPath('img', photo.path);
    request.files.add(image);
    request.headers.addAll({'Authorization': token!});
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully!');
    } else {
      print('Error uploading image. Status code: ${response.statusCode}');
    }
  }
}
