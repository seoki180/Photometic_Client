import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    return const MaterialApp(
      home: StartScreen(),
    );
  }
}
