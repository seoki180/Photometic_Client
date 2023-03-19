import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:photometic/constant/api_constant.dart';
import 'package:photometic/models/login_model.dart';
import 'package:photometic/models/register_model.dart';

class UserRepositories {
  static const storage = FlutterSecureStorage();

  Future Register({required RegisterModel registerModel}) async {
    String url = "$LocalUrl/users/register";
    final registerModelToJson = registerModel.toJson();

    try {
      final Response response =
          await http.post(Uri.parse(url), body: registerModelToJson);
      final res = json.decode(response.body);
      print(res);
      // if (response.statusCode == 200) {
      //   await storage.write(
      //     key: 'token',
      //     value: res['data']['accessToken'],
      //   );
      // }
      return res;
    } catch (err) {
      print(err);
    }
  }

  Future Login({required LoginModel loginModel}) async {
    String url = "$LocalUrl/users/login";
    final loginModelToJson = loginModel.toJson();

    try {
      final Response response =
          await http.post(Uri.parse(url), body: loginModelToJson);
      final res = json.decode(response.body);
      return res;
    } catch (err) {
      print(err);
    }
  }
}
