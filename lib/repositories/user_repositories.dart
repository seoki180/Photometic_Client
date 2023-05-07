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
    String url = "$LocalUrl/auth/register";
    final registerModelToJson = registerModel.toJson();

    try {
      final Response response =
          await http.post(Uri.parse(url), body: registerModelToJson);

      if (response.statusCode == 500) {
        throw Error();
      } else {
        final data = json.decode(response.body);
        return data;
      }
    } catch (err) {
      return {
        "code": 500,
        "isSuccess": false,
        "msg": err,
      };
    }
  }

  Future Login({required LoginModel loginModel}) async {
    String url = "$LocalUrl/auth/login";
    final loginModelToJson = loginModel.toJson();

    try {
      final Response response =
          await http.post(Uri.parse(url), body: loginModelToJson);

      if (response.statusCode == 500) {
        throw Error();
      } else {
        final data = json.decode(response.body);
        await storage.write(
          key: "token",
          value: data["result"]["access"],
        );
        return data;
      }
    } catch (err) {
      return {
        "code": 500,
        "isSuccess": false,
        "msg": err,
      };
    }
  }

  Future getPhotoInfo() async {
    String url = "$LocalUrl/photo";
    String? token = await storage.read(key: "token");

    try {
      final Response response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: token!},
      );
      if (response.statusCode == 500) {
        throw Error();
      } else {
        var data = json.decode(response.body);
        return (data["result"]);
      }
    } catch (err) {
      return {
        "code": 500,
        "isSuccess": false,
        "msg": err,
      };
    }
  }

  Future deletePhoto(idx) async {
    String url = "$LocalUrl/photo/$idx";
    String? token = await storage.read(key: "token");

    try {
      final Response response = await http.delete(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: token!},
      );
      if (response.statusCode == 500) {
        throw Error();
      } else {
        var data = json.decode(response.body);
        return data;
      }
    } catch (err) {
      return {
        "code": 500,
        "isSuccess": false,
        "msg": err,
      };
    }
  }

  Future getInfo() async {
    String url = "$LocalUrl/user/info";
    String? token = await storage.read(key: "token");

    try {
      final Response response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: token!},
      );
      if (response.statusCode == 500) {
        throw Error();
      }
      var data = json.decode(response.body);
      return data;
    } catch (err) {
      return {
        "code": 500,
        "isSuccess": false,
        "msg": err,
      };
    }
  }

  Future changeProfile(photo) async {
    String url = "$LocalUrl/user/profile";
    String? token = await storage.read(key: "token");
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      var image = await http.MultipartFile.fromPath('img', photo.path);
      request.files.add(image);
      request.headers.addAll({'Authorization': token!});
      var response = await request.send();

      if (response.statusCode == 500) {
        throw Error();
      } else {
        var responseBody = await response.stream.bytesToString();
        var decodedResponse = json.decode(responseBody);
        return decodedResponse;
      }
    } catch (err) {
      return {
        "code": 500,
        "isSuccess": false,
        "msg": err,
      };
    }
  }

  Future uploadPhoto(photo) async {
    String url = "$LocalUrl/photo/upload";
    String? token = await storage.read(key: "token");
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      var image = await http.MultipartFile.fromPath('img', photo.path);
      request.files.add(image);
      request.headers.addAll({'Authorization': token!});

      var response = await request.send();
      if (response.statusCode == 500) {
        throw Error();
      } else {
        var responseBody = await response.stream.bytesToString();
        var decodedResponse = json.decode(responseBody);
        return decodedResponse;
      }
    } catch (err) {
      return {
        "code": 500,
        "isSuccess": false,
        "msg": err,
      };
    }
  }
}
