import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  final String baseUrl = "http://13.125.119.220:52000";

  Future<Map> postLogin(loginInfo) async {
    final url = Uri.parse("$baseUrl/login");
    http.Response response = await http.post(url, body: loginInfo);
    return jsonDecode(response.body);
  }

  Future<Map> postRegister(RegisterInfo) async {
    final url = Uri.parse("$baseUrl/register");
    http.Response response = await http.post(url, body: RegisterInfo);
    return jsonDecode(response.body);
  }
}
