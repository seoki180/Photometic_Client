import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photometic/services/api_services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  sendRegisterInfo() async {
    Map RegisterInfo = {
      "id": idController.text,
      "password": passwordController.text,
      "name": nameController.text,
    };
    Map<dynamic, dynamic> result =
        await ApiServices().postRegister(RegisterInfo);
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Text(
                    "환영합니다 새로운 회원님!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[200],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
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
                            TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                labelText: "NAME",
                              ),
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              width: 100,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  sendRegisterInfo();
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
