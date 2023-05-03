import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photometic/models/register_model.dart';
import 'package:photometic/repositories/user_%20repositories.dart';
import 'package:provider/provider.dart';

final GlobalKey<FormState> formkey = GlobalKey();

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
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
                    key: formkey,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: const [
                          RegisterForm(),
                        ],
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

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    void moveScreen() async {
      Navigator.of(context).pushReplacementNamed('/login');
    }

    final registerState = Provider.of<RegisterModel>(context, listen: false);
    return Column(
      children: [
        TextFormField(
          onChanged: (id) => {
            registerState.setId(id),
          },
          decoration: const InputDecoration(
            labelText: "ID",
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (id) {
            if (id!.isEmpty) {
              return "아이디를 입력해주세요";
            } else if (id.length < 5) {
              return "아이디는 최소 5자 이상입니다";
            } else if (id.length > 20) {
              return "아이디는 최대 20자 입니다";
            }
            return null;
          },
        ),
        TextFormField(
          onChanged: (password) => {
            registerState.setPassword(password),
          },
          decoration: const InputDecoration(
            labelText: "PASSWORD",
          ),
          keyboardType: TextInputType.text,
          obscureText: true,
          validator: (password) {
            if (password!.isEmpty) {
              return "비밀번호를 입력해주세요";
            } else if (password.length < 8) {
              return "비밀번호는 최소 8자 이상입니다.";
            } else if (password.length > 20) {
              return "비밀번호는 최대 20자 입니다";
            }
            return null;
          },
        ),
        TextFormField(
          onChanged: (name) => {
            registerState.setName(name),
          },
          decoration: const InputDecoration(
            labelText: "NAME",
          ),
          keyboardType: TextInputType.text,
          validator: (name) {
            if (name!.isEmpty) {
              return "이름을 입력해주세요";
            } else if (name.isEmpty) {
              return "이름은 최소 2자 이상입니다";
            } else if (name.length > 20) {
              return "이름은 최대 20자 입니다";
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
                  UserRepositories userRepositories = UserRepositories();
                  var res = await userRepositories.Register(
                      registerModel: registerState);
                  if (res["code"] == 200) {
                    moveScreen();
                  }
                  Fluttertoast.showToast(msg: res.toString());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[200],
              ),
              child: const Icon(Icons.arrow_forward),
            ),
          ),
        )
      ],
    );
  }
}
