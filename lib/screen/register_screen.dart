import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photometic/models/register_model.dart';
import 'package:photometic/repositories/user_%20repositories.dart';
import 'package:photometic/screen/home_screen.dart';
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
    return ChangeNotifierProvider(
      create: (_) => RegisterModel(),
      child: Scaffold(
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
                    RegisterForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form RegisterForm() {
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
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: const [
              IdInput(),
              PasswordInput(),
              NameInput(),
              SizedBox(
                height: 40,
              ),
              RegisterButton(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final registerModel = Provider.of<RegisterModel>(context, listen: false);

    return SizedBox(
      width: 100,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (formkey.currentState!.validate()) {
            UserRepositories userRepositories = UserRepositories();
            var res =
                await userRepositories.Register(registerModel: registerModel);
            if (res["code"] == 200) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }
            Fluttertoast.showToast(msg: res.toString());
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[200],
        ),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

class NameInput extends StatelessWidget {
  const NameInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final registerModel = Provider.of<RegisterModel>(context);

    return TextFormField(
      onChanged: (name) => {
        registerModel.setName(name),
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
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    //provider 를 통한 상태변화 감지
    final registerModel = Provider.of<RegisterModel>(context);

    return TextFormField(
      onChanged: (password) => {
        registerModel.setPassword(password),
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
    );
  }
}

class IdInput extends StatelessWidget {
  const IdInput({super.key});

  @override
  Widget build(BuildContext context) {
    final registerModel = Provider.of<RegisterModel>(context);
    return TextFormField(
      onChanged: (id) => {
        registerModel.setId(id),
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
    );
  }
}
