import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:photometic/repositories/user_repositories.dart';

const storage = FlutterSecureStorage();

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final userRepositories = UserRepositories();
  final storage = const FlutterSecureStorage();
  // 처음에 그냥 토큰 검사하고, 토큰이 있으면 서버로 보내서 검사

  Future<bool> checkLogin() async {
    var token = await storage.read(key: "token");
    if (token != null) {
      final res = await userRepositories.getInfo();
      if (res["isSuccess"]) {
        return true; //Login 성공
      }
      return false; //Login 실패
    }
    return false; //Token 만료
  }

  void moveScreen() async {
    await checkLogin().then(
      (isLogin) async {
        if (isLogin) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        } else {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/start', (rotue) => false);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      moveScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/img_splash.gif"),
          ],
        ),
      ),
    );
  }
}
