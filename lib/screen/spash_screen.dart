import 'dart:async';
import 'package:flutter/material.dart';
import 'package:photometic/repositories/user_%20repositories.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Future<bool> checkLogin() async {
    final userRepositories = UserRepositories();
    var result = await userRepositories.Profile();
    if (result == '') {
      return false;
    }
    return true;
  }

  void moveScreen() async {
    await checkLogin().then((isLogin) async {
      if (isLogin) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.of(context).pushReplacementNamed('/start');
      }
    });
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
