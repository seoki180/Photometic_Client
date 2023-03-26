// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:photometic/models/login_model.dart';
// import 'package:photometic/repositories/user_%20repositories.dart';
// import 'package:photometic/screen/start_screen.dart';
// import 'package:provider/provider.dart';

// final loginModel = LoginModel();

// class HomeTab extends StatelessWidget {
//   const HomeTab({super.key});

//   static const storage = FlutterSecureStorage();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Consumer<LoginModel>(
//           builder: (context, value, child) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("환영합니다 ${value.getId()}"),
//                 ElevatedButton(
//                   onPressed: () async {
//                     var userRepository = UserRepositories();
//                     var result = await userRepository.getProfile();
//                     Fluttertoast.showToast(msg: result["data"].toString());
//                   },
//                   child: const Text("유저정보 보기"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     storage.delete(key: 'token');
//                     Fluttertoast.showToast(msg: "로그아웃");
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const StartScreen()),
//                     );
//                   },
//                   child: const Text("로그아웃"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     var token = await storage.readAll();
//                     Fluttertoast.showToast(msg: token.toString());
//                   },
//                   child: const Text("토큰보기"),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:photometic/models/login_model.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    final LoginModel loginModel = Provider.of<LoginModel>(context);
    return Scaffold(
      body: Center(
        child: Text("hello ${loginModel.getId()}"),
      ),
    );
  }
}
