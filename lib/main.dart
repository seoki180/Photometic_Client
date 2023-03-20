import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photometic/screen/home_screen.dart';
import 'package:photometic/screen/login_screen.dart';
import 'package:photometic/screen/register_screen.dart';
import 'package:photometic/screen/spash_screen.dart';
import 'package:photometic/screen/start_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final myId = TextEditingController();
  final myPassword = TextEditingController();

  void showToast() {
    String data = "${myId.text} / ${myPassword.text}";
    Fluttertoast.showToast(
      msg: data,
    );
  }

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/start': (context) => const StartScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
