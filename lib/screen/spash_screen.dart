import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:photometic/repositories/user_%20repositories.dart';

const storage = FlutterSecureStorage();

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final userRepositories = UserRepositories();
  // 처음에 그냥 토큰 검사하고, 토큰이 있으면 서버로 보내서 검사
  Future<bool> checkLogin() async {
    final res = userRepositories.getProfile();
    if (res == '') {
      return false;
    }
    return true;
  }

  void moveScreen() async {
    await checkLogin().then(
      (isLogin) async {
        if (isLogin) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          Navigator.of(context).pushReplacementNamed('/start');
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
