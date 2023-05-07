import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photometic/models/login_model.dart';
import 'package:photometic/repositories/user_repositories.dart';
import 'package:provider/provider.dart';

final GlobalKey<FormState> formkey = GlobalKey();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
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
                    height: 250,
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
                    key: formkey,
                    child: Theme(
                      data: ThemeData(
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                            color: Colors.red[200],
                            fontSize: 15,
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: const [
                            LoginForm(),
                            FindPassword(),
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

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    void moveScreen() {
      Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
    }

    final loginState = Provider.of<LoginModel>(context, listen: false);
    return Column(
      children: [
        TextFormField(
          onChanged: (id) {
            loginState.setId(id);
          },
          decoration: const InputDecoration(
            labelText: "ID",
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (id) {
            if (id!.isEmpty) {
              return "아이디를 입력하세요";
            }
            return null;
          },
        ),
        TextFormField(
          onChanged: (password) => loginState.setPassword(password),
          decoration: const InputDecoration(
            labelText: "PASSWORD",
          ),
          keyboardType: TextInputType.text,
          obscureText: true,
          validator: (password) {
            if (password!.isEmpty) {
              return "비밀번호를 입력하세요";
            }
            return null;
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: SizedBox(
            width: 100,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                if (formkey.currentState!.validate()) {
                  var userRepository = UserRepositories();
                  var res = await userRepository.Login(loginModel: loginState);
                  Fluttertoast.showToast(msg: res["message"].toString());
                  if (res["isSuccess"]) {
                    moveScreen();
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[200],
              ),
              child: const Icon(Icons.arrow_forward),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10),
        ),
      ],
    );
  }
}

class FindPassword extends StatelessWidget {
  const FindPassword({super.key});

  void moveScreen(BuildContext context) {
    Navigator.pushNamed(context, "/register");
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        moveScreen(context);
      },
      child: Text(
        "아직 회원이 아니신가요?",
        style: TextStyle(
          color: Colors.red[200],
        ),
      ),
    );
  }
}
