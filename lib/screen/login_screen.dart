import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photometic/models/login_model.dart';
import 'package:photometic/repositories/user_%20repositories.dart';
import 'package:photometic/screen/home_screen.dart';
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
    return ChangeNotifierProvider(
      create: (_) => LoginModel(),
      child: Scaffold(
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
                    LoginForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form LoginForm() {
    return Form(
      key: formkey,
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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: const [
              IdInput(),
              PasswordInput(),
              LoginButton(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              ),
              FindPassword(),
            ],
          ),
        ),
      ),
    );
  }
}

class FindPassword extends StatelessWidget {
  const FindPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        "비밀번호를 까먹으셨나요?",
        style: TextStyle(
          color: Colors.red[200],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final loginModel = Provider.of<LoginModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: SizedBox(
        width: 100,
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            if (formkey.currentState!.validate()) {
              var userRepository = UserRepositories();
              var res = await userRepository.Login(loginModel: loginModel);

              Fluttertoast.showToast(msg: res.toString());
              if (res!["code"] == 200) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[200],
          ),
          child: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final loginModel = Provider.of<LoginModel>(context);

    return TextFormField(
      onChanged: (password) => loginModel.setPassword(password),
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
    );
  }
}

class IdInput extends StatelessWidget {
  const IdInput({super.key});

  @override
  Widget build(BuildContext context) {
    final loginModel = Provider.of<LoginModel>(context);

    return TextFormField(
      onChanged: (id) => loginModel.setId(id),
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
    );
  }
}
