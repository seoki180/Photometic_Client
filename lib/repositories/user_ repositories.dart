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
    String url = "$BaseUrl/users/register";
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
    String url = "$BaseUrl/users/login";
    final loginModelToJson = loginModel.toJson();

    try {
      final Response response =
          await http.post(Uri.parse(url), body: loginModelToJson);
      final res = json.decode(response.body);

      if (response.statusCode == 200) {
        await storage.write(
          key: "token",
          value: res["jwt"]["access"],
        );
      }
      return res;
    } catch (err) {
      return {
        "code": 500,
        "msg": err,
      };
    }
  }

  // Future getProfile() async {
  //   String url = "$BaseUrl/users/profile";
  //   String? token = await storage.read(key: "token");

  //   try {
  //     final Response response = await http.get(
  //       Uri.parse(url),
  //       headers: {HttpHeaders.authorizationHeader: token!},
  //     );
  //     if (response.statusCode == 200) {
  //       var res = json.decode(response.body);
  //       return res;
  //     } else {
  //       return {
  //         "code": 419,
  //         "msg": "token expired",
  //       };
  //     }
  //   } catch (err) {
  //     return {
  //       "code": 500,
  //       "msg": err,
  //     };
  //   }
  // }

  Future getProfile() async {
    String? token = await storage.read(key: 'token');
    String url = "$LocalUrl/users/check";

    try {
      final Response response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: token!},
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data["data"]["userName"];
      } else {
        return '';
      }
    } catch (err) {
      return '';
    }
  }
}
