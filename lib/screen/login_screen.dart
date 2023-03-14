import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photometic/services/api_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void sendingLoginInfo() async {
    Map<String, String> LoginInfo = {
      "id": idController.text,
      "password": passwordController.text,
    };
    Map<dynamic, dynamic> result = await ApiServices().postLogin(LoginInfo);
    Fluttertoast.showToast(msg: result.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 300,
                  ),
                  Text(
                    "어서오세요!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[200],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    child: Theme(
                      data: ThemeData(
                        primaryColor: const Color.fromRGBO(71, 126, 121, 1),
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                            color: Colors.red[200],
                            fontSize: 15,
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            TextField(
                              controller: idController,
                              decoration: const InputDecoration(
                                labelText: "ID",
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            TextField(
                              controller: passwordController,
                              decoration: const InputDecoration(
                                labelText: "PASSWORD",
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              width: 100,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  sendingLoginInfo();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red[200],
                                ),
                                child: const Icon(Icons.arrow_forward),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
